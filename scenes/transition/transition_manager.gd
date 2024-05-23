# ======================================================================
# 名称：transition_manager
# 类型：场景过渡管理器
# 简介：管理场景的切换过渡动效
# 作者：彭亮
# Godot版本：Godot_v4.2.2-stable_win64
# ======================================================================

extends Node

const transition_node_name = "transition_node"	# 过渡节点名称
var is_showing_transition = false

var function_to_call: Callable # 预定义变量，用来保存动态调用的函数

enum TRANSITION_TYPE{
	ZOOM_OUT=1,
	SWIPE_RIGHT=2,
	FALL_DOWN=3
}

# 截屏显示过渡动画
func setup_sprite():
	# 加载过渡场景
	var transition_sprite = load("res://scenes/transition/transition_sprite.tscn").instantiate() as Sprite2D
	# 视口截屏生成图片
	var image = get_viewport().get_texture().get_image()
	# 创建过渡纹理
	var transition_texture = ImageTexture.create_from_image(image)
	transition_sprite.name = transition_node_name
	# 将截屏生成的过渡纹理赋值给过渡场景
	transition_sprite.texture = transition_texture
	return transition_sprite

# 切换场景，new_scene_location: 场景路径， transition_type: 过渡动画类型
func change_scene(new_scene_location: String, transition_type: int):
	if is_showing_transition:
		return
	is_showing_transition = true
	# 截屏
	var transition_sprite = setup_sprite()
	# 更新场景
	get_tree().change_scene_to_file(new_scene_location)
	function_to_call = show_transition.bind(transition_sprite, transition_type)
	get_tree().node_added.connect(function_to_call)

func show_transition(_new_node, transition_sprite: Sprite2D, type: TRANSITION_TYPE):
	# 过渡节点若已经存在，立即退出，不重复执行
	if get_tree().root.get_node_or_null(transition_node_name) != null:
		return
	get_tree().root.add_child(transition_sprite)
	# 创建一个并行的补间动画， set_parallel 将动画改为并行，而非逐次执行
	var transition_tween = create_tween().set_parallel()
	
	if type == TRANSITION_TYPE.ZOOM_OUT:
		# 添加过渡曲线
		transition_tween.set_trans(Tween.TRANS_CUBIC)
		# 缩放动画
		transition_tween.tween_property(transition_sprite, "scale", Vector2(0.01, 0.01), 1)
	elif type == TRANSITION_TYPE.SWIPE_RIGHT:
		# 右移
		transition_tween.tween_property(transition_sprite, "global_position", Vector2(1800, -400), 1)
		transition_tween.tween_property(transition_sprite, "rotation", deg_to_rad(180), 1)	# 使用deg_to_rad将角度转为弧度，旋转180°
	elif type == TRANSITION_TYPE.FALL_DOWN:
		# 添加过渡曲线
		transition_tween.set_trans(Tween.TRANS_CUBIC)
		# 下落
		transition_tween.tween_property(transition_sprite, "global_position", Vector2(600, 1200), 1)
		
	# 补间动画结束后释放过渡场景
	transition_tween.finished.connect(transition_sprite.queue_free)
	# 等待补间动画结束后更新过渡状态
	await transition_tween.finished
	# 补间动画结束后删除回调链接，否则会报错
	get_tree().node_added.disconnect(function_to_call)
	is_showing_transition = false

func _process(_delta):
	if Input.is_action_just_pressed("ui_up"):
		TransitionManager.change_scene("res://scenes/ui/dialog/dialog_box.tscn", TRANSITION_TYPE.ZOOM_OUT)
	if Input.is_action_just_pressed("ui_down"):
		TransitionManager.change_scene("res://scenes/main/battle.tscn", TRANSITION_TYPE.FALL_DOWN)
	if Input.is_action_just_pressed("ui_right"):
		TransitionManager.change_scene("res://scenes/map/tile_map.tscn", TRANSITION_TYPE.SWIPE_RIGHT)
