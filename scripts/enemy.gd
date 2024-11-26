extends Node2D

@onready var _focus: Sprite2D = $Focus
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var enemy: Node2D = $"."
@onready var impact: Sprite2D = $Impact
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

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
	
func damage_visual():
	impact.show()
	audio_stream_player_2d.play()
	await get_tree().create_timer(.25).timeout
	impact.hide()

func take_damage(value):
	health -= value
	_update_progress_bar()  # Update the progress bar after taking damage
	damage_visual()
	if health <= 0:
		on_death()  # Call the death handler
		
func on_death():
	# Add death animation here
	enemy.hide()
	dead = true
