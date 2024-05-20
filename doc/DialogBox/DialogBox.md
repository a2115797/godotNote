# 交互对话框
将对话框挂载为全局场景自动加载，监听对话信号，在需要显示对话时调用 show_dialog_box 接口传入对话的内容和头像等其它数据
```
extends CanvasLayer

const AVATAR_MAP = {
	"gabe": preload("res://assets/environment/sensei.png"),
	"sens": preload("res://assets/environment/boss_bee.png")
}

var dialogs = []
var current = 0


@onready var contentBox = $ContentBox
@onready var content = $ContentBox/Content
@onready var avatar = $ContentBox/Avatar
@onready var tween: Tween

func _ready():
	hide_dialog_box()
	show_dialog_box([
		{avatar="gabe",text="怪物，还我孙子！"},
		{avatar="sens",text="你孙子早被吃了，嘎嘎！！！"},
		{avatar="gabe",text="混蛋！纳命来！！！"},
		{avatar="sens",text="不要，不要，不要再打了！再打你孙子就死得不要不要的啦！！！"},
	])

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		if current + 1 < dialogs.size():
			if(tween and tween.is_running()):
				tween.kill()
				content.visible_ratio = 1
			else:
				_show_dialog(current + 1)
		else:
			hide_dialog_box()
		get_viewport().set_input_as_handled()

func hide_dialog_box():
	contentBox.hide()
	
func show_dialog_box(_dialogs):
	dialogs = _dialogs
	contentBox.show()
	_show_dialog(0)

func _show_dialog(index):
	current = index
	var dialog = dialogs[index]
	content.visible_ratio = 0
	content.text = dialog.text
	avatar.texture = AVATAR_MAP[dialog.avatar]
	tween = get_tree().create_tween()
	tween.tween_property(content, "visible_ratio", 1, .5).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)

```