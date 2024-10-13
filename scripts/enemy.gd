extends Node2D

@onready var _focus: Sprite2D = $Focus
@onready var progress_bar: ProgressBar = $ProgressBar

@export var MAX_HEALTH: float = 7

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
		_on_death()  # Call the death handler
		
func _on_death():
	# Add any death animation or effect here if desired
	queue_free()  # Remove the enemy from the scene
