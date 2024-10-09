extends Node2D

var enemies: Array = []
var index: int = 0

func _ready():
	enemies = get_children()
	for i in enemies.size():
		enemies[i].position = Vector2(i*100, i*100)

	enemies[0].focus()

func _process(_delta):
	if Input.is_action_just_pressed("down"):
		if index < enemies.size() - 1:
			index += 1
			switch_focus(index, index-1)
	if Input.is_action_just_pressed("up"):
		if index > 0:
			index -= 1
			switch_focus(index, index+1)
	if Input.is_action_just_pressed("select"):
		enemies[index].take_damage(1)
			
func switch_focus(x,y):
	enemies[x].focus()
	enemies[y].unfocus()
