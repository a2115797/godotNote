extends BaseCreature

@onready var screen_size = get_viewport_rect().size

func _ready():
	super._ready()
	#level -= 10

#func _process(delta):
	#position = InputMove.catch_input_move(delta, speed, position, screen_size)
	#move_and_slide()
	## move_and_collide()
	
func _physics_process(delta):
	position = InputMove.catch_input_move(delta, speed, position, screen_size)
	move_and_slide()
