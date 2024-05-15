extends BaseCreature

@onready var screen_size = get_viewport_rect().size

func _ready():
	super._ready()
	#level += 40

func _process(delta):
	position = InputMove.catch_input_move(delta, speed, position, screen_size)
	move_and_slide()
	# move_and_collide()
	
