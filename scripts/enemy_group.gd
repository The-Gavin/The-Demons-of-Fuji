extends Node2D

var enemies: Array = []
var action_queue: Array = []
var is_battling: bool = false
var attack: bool = false
var hotFoot: bool = false
var direction: String
var index: int = 0
var move_amount: int = 100
var min_y_position: float = 0  # Minimum Y position
var max_y_position: float = 100  # Maximum Y position
var min_x_position: float = 0  # Minimum Y position
var max_x_position: float = 100
var waiting_for_selection: bool = false
var win = false

@onready var choice: VBoxContainer = $"../CanvasLayer/Choice"

func _ready():
	enemies = get_children()
	for i in enemies.size():
		enemies[i].position = Vector2(i*100, i*100)

	show_choice()

func _process(_delta):
	if get_tree().current_scene.name == "Lava Stage":
		hotFoot = true
	if win:
		get_tree().change_scene_to_file("res://scenes/lava_stage.tscn")
	else:
		if not choice.visible && waiting_for_selection:
			if Input.is_action_just_pressed("down"):
				if index < enemies.size() - 1:
					index += 1
					switch_focus(index, index-1)
			if Input.is_action_just_pressed("up"):
				if index > 0:
					index -= 1
					switch_focus(index, index+1)
			if Input.is_action_just_pressed("select"):
				waiting_for_selection = false
				action_queue.push_back(index)
				attack = true
			
		if action_queue.size() == 1 and not is_battling: #set to 1 because only allowed to take one action, if i wanted to act for every number of enemies there are it'd have to be enemies.size()
			is_battling = true
			_action(action_queue, true, direction)
		
func _action(stack: Array, apply_damage: bool = true, move_direction: String = "down"):
	for i in stack:
		if apply_damage:
			enemies[i].take_damage(1)
			if enemies[i].health <= 0:
				enemies.erase(enemies[i])
				await get_tree().create_timer(.75).timeout
			else:
				await get_tree().create_timer(.75).timeout
				if move_direction == "down":
					move_enemy(i, "down")
				elif move_direction == "up":
					move_enemy(i, "up")
				elif move_direction == "none":
					move_enemy(i, "none")
				elif move_direction == "right":
					move_enemy(i, "right")
		if hotFoot:
			for enemy in enemies:
				if enemy.position.y == max_y_position:
					enemy.take_damage(1)

	if enemies.size() == 0:
		win = true
	else:
		action_queue.clear()
		is_battling = false
		attack = false
		show_choice()

		
func switch_focus(x,y):
	enemies[x].focus()
	enemies[y].unfocus()
	waiting_for_selection = true

func show_choice():
	choice.show()
	choice.find_child("Head").grab_focus()
	
func _reset_focus():
	index = 0
	for enemy in enemies:
		enemy.unfocus()
		
func _start_choosing():
	_reset_focus()
	enemies[0].focus()
	waiting_for_selection = true

func _on_head_pressed() -> void:
	direction = "down" #set direction to send enemy
	choice.hide()
	_start_choosing()

func _on_l_arm_pressed() -> void:
	direction = "up" #set direction to send enemy
	choice.hide()
	_start_choosing()
	
func _on_r_arm_pressed() -> void:
	direction = "right" #set direction to send enemy
	choice.hide()
	_start_choosing()
	
func _on_chest_pressed() -> void:
	direction = "none" #set direction to send enemy
	hotFoot = true
	choice.hide()
	_start_choosing()

func move_enemy(selected_index: int, direction: String):
	var enemy = enemies[selected_index]
	
	# Set the Y position based on the direction
	if direction == "down":
		var savedX = enemy.position.x
		var savedY = enemy.position.y
		if enemy.position.y != max_y_position:
			enemy.position.y = max_y_position  # Set to maximum Y position
			enemy.take_damage(1)
			if enemies.size() > 1:
				var enemy2 = enemies[selected_index + 1]
				if enemy.position.x == enemy2.position.x && enemy.position.y == enemy2.position.y:
					enemy.take_damage(1)
					enemy2.take_damage(1)
					enemy.position.x = savedX
					enemy.position.y = savedY
	elif direction == "up":
		var savedX = enemy.position.x
		var savedY = enemy.position.y
		if enemy.position.y != min_y_position:
			enemy.position.y = min_y_position
			if enemies.size() > 1:
				var enemy2 = enemies[selected_index + 1]
				if enemy.position.x == enemy2.position.x && enemy.position.y == enemy2.position.y:
					enemy.take_damage(1)
					enemy2.take_damage(1)
					enemy.position.x = savedX
					enemy.position.y = savedY  # Set to minimum Y position
	elif direction == "none":
		print("No Movement") #Used for moves that do not move the enemy
	elif direction == "right":
		var savedX = enemy.position.x
		var savedY = enemy.position.y
		if enemy.position.x != max_x_position:
			enemy.position.x = max_x_position
			if enemies.size() > 1:
				var enemy2 = enemies[selected_index + 1]
				if enemy.position.x == enemy2.position.x && enemy.position.y == enemy2.position.y:
					enemy.take_damage(1)
					enemy2.take_damage(1)
					enemy.position.x = savedX
					enemy.position.y = savedY
