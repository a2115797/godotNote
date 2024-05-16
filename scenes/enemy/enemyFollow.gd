class_name EnemyFollow extends State

@export var enemy: CharacterBody2D
@export var move_speed := 50.0

var player: CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group('Player')

func PhysicsUpdate(delta: float):
	if !player or !enemy:
		enemy.velocity = Vector2.ZERO
		return
	
	var direction = player.global_position - enemy.global_position

	if direction.length() > 25:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()

	if direction.length() > 80:
		Transitioned.emit(self, "EnemyIdle")
