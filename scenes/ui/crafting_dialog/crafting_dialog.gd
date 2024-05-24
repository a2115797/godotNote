# ======================================================================
# 名称：CraftingDialog
# 类型：物品合成界面
# 简介：用于提供打开背包，将库存物品遍历显示
# 作者：彭亮
# Godot版本：Godot_v4.2.2-stable_win64
# ======================================================================
class_name CraftingDialog extends PanelContainer

@export var slot_scene: PackedScene

@onready var recipe_list: ItemList = %RecipeList
@onready var ingredients_container: ItemGrid = %IngredientsContainer
@onready var results_container: ItemGrid = %ResultsContainer
@onready var craft_button: Button = %CraftButton

# 定义成员变量保存用户的库存和选中的配方
var _inventory: Inventory
var _selected_recipe: Recipe

func _ready():
	%CloseButton.pressed.connect(_on_close_button_pressed)
	craft_button.pressed.connect(_on_craft_button_pressed)
	recipe_list.item_selected.connect(_on_recipe_list_item_selected)
	
# 打开合成弹窗，传入配方表和库存数据
func open(recipes: Array[Recipe], inventory: Inventory):
	_inventory = inventory
	show()
	
	# 清空配方表
	recipe_list.clear()
	
	for recipe in recipes:
		var index = recipe_list.add_item(recipe.name)
		recipe_list.set_item_metadata(index, recipe)
	
	# 打开界面默认选中第一条
	recipe_list.select(0)
	# 通过代码选中不会触发selected事件，需要动调用事件处理函数
	_on_recipe_list_item_selected(0)
	
func _on_close_button_pressed():
	hide()

# 选中成配方
func _on_recipe_list_item_selected(index):
	_selected_recipe = recipe_list.get_item_metadata(index)
	ingredients_container.display(_selected_recipe.ingredients)
	results_container.display(_selected_recipe.results)
	
	craft_button.disabled = not _inventory.has_all(_selected_recipe.ingredients)

# 点击合成按钮后进行物品合成
func _on_craft_button_pressed():
	# 获取配方中需要的材料，使其从库存中移除
	for item in _selected_recipe.ingredients:
		_inventory.remove_item(item)
	
	# 取配方中的合成的物品，添加到库存
	for item in _selected_recipe.results:
		_inventory.add_item(item)
