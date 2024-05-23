class_name InventoryDialog extends PanelContainer

@export var slot_scene: PackedScene

@onready var grid_container: GridContainer = %GridContainer

func _ready():
	%CloseButton.pressed.connect(_on_close_button_pressed)
	
# 打开背包，传入库存数据
func open(inventory: Inventory):
	show()
	
	# 清空背包，避免与之前的数据混合
	for child in grid_container.get_children():
		child.queue_free()
	
	# 遍历背包，将物品添加到背包界面
	for item in inventory.get_items():
		var slot = slot_scene.instantiate()
		# 必须先添加到场景中，添加到场景后实例化 slot 组件才能访问 display 方法
		grid_container.add_child(slot)
		slot.display(item)
	
func _on_close_button_pressed():
	hide()
