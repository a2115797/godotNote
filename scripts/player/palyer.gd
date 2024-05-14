extends "res://scripts/classes/BaseCreature.gd"

var inputMove = load("res://scripts/extend/inputMove.gd")
var input_move_instance = inputMove.new()

var screen_size

func _ready():
	speed = 300
	screen_size = get_viewport_rect().size

func _process(delta):
	position = input_move_instance.catch_input_move(delta, speed, position, screen_size)
	move_and_slide()
	# move_and_collide()
	
