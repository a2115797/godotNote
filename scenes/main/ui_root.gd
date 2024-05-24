extends CanvasLayer

@onready var player: BaseCreature = %Player
@onready var inventory_dialog: InventoryDialog = %InventoryDialog
@onready var crafting_dialog: CraftingDialog = %CraftingDialog

const IRON_INGOT = preload("res://resources/recipes/iron_ingot.tres")
const SWORD = preload("res://resources/recipes/sword.tres")

func _unhandled_input(event):
	# 输入打开背包按键时，打开背包并把 player 的背包数据传入背包界面组件
	if event.is_action_pressed("inventory"):
		inventory_dialog.open(player.inventory)
	if event.is_action_pressed("crafting"):
		crafting_dialog.open([IRON_INGOT, SWORD],player.inventory)
