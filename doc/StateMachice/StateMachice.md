# 有限状态机
角色通常会具有多种状态，如奔跑、等待、攻击等，各种状态间可以通过有限状态机来进行切换

### 如何使用
创建一个继承自 State 的脚本，除了该状态需要执行的逻辑之外，在需要切换到其它状态时发送 Transitioned 信号通知父节点 StateMachice 切换到其它状态即可 
```
extends State

class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var move_speed := 10.0

var move_direction: Vector2
var wander_timer: float
var player: CharacterBody2D

# 随机游荡
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
```

### 定义状态类
State 作为状态模板，定义了几个必须实现的方法，由继承的类去实现具体功能.
定义了 Transitioned 信号，用于在需要切换到其它状态时通知 StateMachice 切换到下一个状态，发送信号时需携带要切换的状态节点名称如 Transitioned.emit(self, "EnemyFollow")
```
class_name State extends Node

signal Transitioned

# 进入状态时调用
func Enter():
    pass

# 离开当前状态时调用
func Exit():
    pass

# StateMachice 会在 _process 函数中进行调用
func Update(_delta:float):
    pass

# StateMachice 会在 _physics_process 函数中调用
func PhysicsUpdate(_delta:float):
    pass
```

### 状态机
遍历所有子节点，将子节点中的所有状态保存在字典中并链接子节点的 Transitioned 信号，当子节点发送 Transitioned 信号时切换到对应状态。

```
class_name StateMachice extends Node

@export var initial_state : State	#初始化状态

var current_state : State			# 当前状态
var states : Dictionary = {}		# 状态字典

func _ready():
    for child in get_children():
        if child is State:
            states[child.name.to_lower()] = child
            child.Transitioned.connect(on_child_transition)
	
    if initial_state:
        initial_state.Enter()
        current_state = initial_state

func _process(delta):
    if current_state:
        current_state.Update(delta)

func _physics_process(delta):
    if current_state:
        current_state.PhysicsUpdate(delta)

func on_child_transition(state, new_state_name):
    if state != current_state:
        return
    var new_state = states.get(new_state_name.to_lower())
    if !new_state:
        return
	
    if current_state:
        current_state.Exit()
	
    new_state.Enter()
	
    current_state = new_state
	
```