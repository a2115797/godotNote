extends CanvasLayer

@export var all_recipes: ResourceGroup

@onready var player: BaseCreature = %Player
@onready var inventory_dialog: InventoryDialog = %InventoryDialog
@onready var crafting_dialog: CraftingDialog = %CraftingDialog

var _all_recipes: Array[Recipe] = []

func _ready():
	# 使用 ResourceGroup 插件动态加载 recipes 目录里的配方
	all_recipes.load_all_into(_all_recipes)
	

func _unhandled_input(event):
	# 输入打开背包按键时，打开背包并把 player 的背包数据传入背包界面组件
	if event.is_action_pressed("inventory"):
		inventory_dialog.open(player.inventory)
	if event.is_action_pressed("crafting"):
		crafting_dialog.open(_all_recipes,player.inventory)

