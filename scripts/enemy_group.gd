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
		
	if action_queue.size() == enemies.size() and not is_battling:
		is_battling = true
		_action(action_queue)
		
func _action(stack):
	for i in stack:
		enemies[i].take_damage(1)
		await get_tree().create_timer(1).timeout
		move_enemy(i, "down")
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
	choice.find_child("L Arm").grab_focus()
	
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
	move_enemy(index, "down")
	
func _on_l_arm_pressed() -> void:
	choice.hide()
	_start_choosing()
	move_enemy(index, "up")


func move_enemy(selected_index: int, direction: String):
	# Move the selected enemy's Y position, within limits
	var enemy = enemies[selected_index]
	var new_y_position = enemy.position.y

	# Adjust position based on the direction
	if direction == "down":
		new_y_position += move_amount  # Move down (increase Y)
	elif direction == "up":
		new_y_position -= move_amount  # Move up (decrease Y)

	# Check if the new position is within the limits
	if new_y_position < min_y_position:
		new_y_position = min_y_position
	elif new_y_position > max_y_position:
		new_y_position = max_y_position

	enemy.position.y = new_y_position  # Update the enemy's position
