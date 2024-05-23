extends CanvasLayer

@onready var player: BaseCreature = %Player
@onready var inventory_dialog: InventoryDialog = %InventoryDialog

func _unhandled_input(event):
	# 输入打开背包按键时，打开背包并把 player 的背包数据传入背包界面组件
	if event.is_action_pressed("inventory"):
		inventory_dialog.open(player.inventory)
