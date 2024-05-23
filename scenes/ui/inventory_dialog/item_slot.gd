extends PanelContainer

@onready var texture_reac: TextureRect = %TextureRect

# 显示物品 Icon
func display(item:Item):
	texture_reac.texture = item.icon
