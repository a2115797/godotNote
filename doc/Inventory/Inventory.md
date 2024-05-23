### 背包
背包用于保存角色拥有的物品

添加 Inventory Class, 暂时不需要具备节点功能因此继承自 RefCounted。
Class 默认继承自 RefCounted, 因此 extends RefCounted 可以移除
```
class_name Inventory extends RefCounted

var _content: Array[Item] = []

func add_item(item:Item):
	_content.append(item)

func remove_item(item:Item):
	_content.erase(item)

func get_items() -> Array[Item]:
	return _content
```

给 Player 添加背包

```
# Player.gd

# 创建背包
var inventory: Inventory = Inventory.new()

func on_item_picked_up(item: Item):
	# 添加物品到背包
	inventory.add_item(item)
```