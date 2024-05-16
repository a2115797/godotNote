extends State

class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var move_speed := 10.0

var move_direction: Vector2
var wander_timer: float
var player: CharacterBody2D

func randomize_wander():
	move_direction = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	wander_timer = randf_range(1, 3)

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	randomize_wander()

func Update(delta: float):
	if wander_timer > 0:
		wander_timer -= delta
	else:
		randomize_wander()

func PhysicsUpdate(delta: float):
	var direction = enemy.global_position - player.global_position
	
	if direction.length() < 80:
		Transitioned.emit(self, "EnemyFollow")
	
	else:
		enemy.velocity = move_direction * move_speed
	
