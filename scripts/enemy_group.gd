extends Node2D

var enemies: Array = []
var action_queue: Array = []
var is_battling: bool = false
var index: int = 0
var move_amount: int = 100
var min_y_position: float = 0  # Minimum Y position
var max_y_position: float = 100  # Maximum Y position

@onready var choice: VBoxContainer = $"../CanvasLayer/Choice"

func _ready():
	enemies = get_children()
	for i in enemies.size():
		enemies[i].position = Vector2(i*100, i*100)

	show_choice()

func _process(_delta):
	if not choice.visible:
		if Input.is_action_just_pressed("down"):
			if index < enemies.size() - 1:
				index += 1
				switch_focus(index, index-1)
		if Input.is_action_just_pressed("up"):
			if index > 0:
				index -= 1
				switch_focus(index, index+1)
		if Input.is_action_just_pressed("select"):
			action_queue.push_back(index)
		
	if action_queue.size() == 1 and not is_battling: #set to 1 because only allowed to take one action, if i wanted to act for every number of enemies there are it'd have to be enemies.size()
		is_battling = true
		_action(action_queue)
		
func _action(stack: Array, apply_damage: bool = true, move_direction: String = "down"):
	for i in stack:
		if apply_damage:
			enemies[i].take_damage(1)  # You can also customize the damage amount based on the enemy type if needed
		await get_tree().create_timer(1).timeout
		
		if move_direction == "down":
			move_enemy(i, "down")
		elif move_direction == "up":
			move_enemy(i, "up")

	action_queue.clear()
	is_battling = false
	show_choice()

		
func switch_focus(x,y):
	enemies[x].focus()
	enemies[y].unfocus()

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

func _on_head_pressed() -> void:
	choice.hide()
	_start_choosing()
	_action([index], true, "down")  # Call _action with damage and move down

func _on_l_arm_pressed() -> void:
	choice.hide()
	_start_choosing()
	_action([index], true, "up")  # Call _action with damage and move up

func move_enemy(selected_index: int, direction: String):
	var enemy = enemies[selected_index]

	# Set the Y position based on the direction
	if direction == "down":
		if enemy.position.y != max_y_position:
			enemy.position.y = max_y_position  # Set to maximum Y position
			enemy.take_damage(1)
	elif direction == "up":
		enemy.position.y = min_y_position  # Set to minimum Y position
