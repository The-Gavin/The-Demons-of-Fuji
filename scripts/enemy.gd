extends Node2D

@onready var _focus: Sprite2D = $Focus
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var enemy: Node2D = $"."

@export var MAX_HEALTH: float = 7

var dead: bool = false
var health: float = 7:
	set(value):
		health = value
		_update_progress_bar()

func _ready():
	_update_progress_bar()  # Ensure the progress bar is set on initialization

func _update_progress_bar():
	progress_bar.value = (health/MAX_HEALTH) * 100
	
func focus():
	_focus.show()
 
func unfocus():
	_focus.hide()

func take_damage(value):
	health -= value
	_update_progress_bar()  # Update the progress bar after taking damage
	if health <= 0:
		on_death()  # Call the death handler
		
func on_death():
	# Add death animation here
	enemy.hide()
	dead = true
