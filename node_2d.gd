extends Node2D
#State machine for starting battle

enum States {Start, PlayerTurn, EnemyTurn}

@onready var triggerExplosionButton = $TriggerExplosion
#@onready var stateMachine = $StateMachine
@export var state = States.Start

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_1_pressed() -> void:
	print("button one pressed")


func _on_trigger_explosion_pressed() -> void:
	print("start explosion")
	# Store the original text for later.
	var original_text = triggerExplosionButton.text
	# change the text and disable the button so it can't be clicked twice.
	triggerExplosionButton.text = "awaiting.."
	triggerExplosionButton.disabled = true
	# This will wait for 1 second until the timeout is triggered
	# before advancing to the next line
	await get_tree().create_timer(1).timeout
	print("end explosion")
	# Restore the button state
	triggerExplosionButton.text = original_text
	triggerExplosionButton.disabled = false
	


func state_transition(prev_state: States, next_state: States) -> void:
	print(States.keys()[prev_state], " -> ", States.keys()[next_state])
	state = next_state


func _on_transition_state_pressed() -> void:
	
	match state:
		States.Start:
			state_transition(state, States.PlayerTurn)
		States.PlayerTurn:
			state_transition(state, States.EnemyTurn)
		States.EnemyTurn:
			state_transition(state, States.PlayerTurn)
		_:
			printerr("No match: " + state)
	
