extends BaseCreature

@export var navigation_agent_2d: NavigationAgent2D

func _ready():
	super._ready()
	
func _physics_process(delta) -> void:
	move(delta)
	
func move(_delta) -> void:
	# 键盘控制上下左右移动
	velocity = InputMove.catch_input_move(speed)
	move_and_slide() # move_and_slide 内部已经计算过速率，因此不需要乘以 delta
	# move_and_collide 需要乘以delta
	#move_and_collide(velocity * delta)
	
	# 距离目标点距离大于1时，使用NavigationAgent2d进行导航
	#if int(navigation_agent_2d.distance_to_target() > 1):
		#var direction = to_local(navigation_agent_2d.get_next_path_position()).normalized()
		#velocity = direction * speed
		#move_and_slide()
	#else:
		#velocity = Vector2.ZERO

func _unhandled_input(event :InputEvent) -> void:
	if !event.is_action("mouse_left") or navigation_agent_2d == null:
		return

	navigation_agent_2d.target_position = get_global_mouse_position()
