# ======================================================================
# 名称：BaseCreature
# 类型：生物基类
# 简介：初始化生物（怪物、角色）的基础属性，生物拥有基础特性如生命、攻击力、防御力、移动度等
# 作者：彭亮
# Godot版本：Godot_v4.2.2-stable_win64
# ======================================================================
class_name BaseCreature extends CharacterBody2D

# ========================== 信号 ======================================
signal health_depleted # 生命值耗尽信号 仅表命值耗尽，也许可以复活，不一定死亡
signal creature_death # 死亡信号 真正的死亡信号


# ========================== 面板参数 ===================================
@export_group("基础属性")
@export var level: int = 0: 					# 等级
	set = _set_level

@export var experience: int = 0 						# 经验值 experience point
@export var max_experience: int = 10 					# 升级所需经验值
@export var max_hp: int = 1 					# 最大生命值
@export var hp: int = 1 						# 当前生命值 hit_points

@export var max_mp: int = 0 					# 最大法力值
@export var mp: int = 0 						# 当前法力值 mana_points

@export var damage: int = 0 					# 攻击力
@export var physical_damage: int = 0 			# 物理攻击力
@export var magical_damage: int = 0 			# 魔法攻击力
@export var defence: int = 0 					# 防御力
@export var physical_defence: int = 0 			# 物理防御
@export var magical_defence: int = 0 			# 法术防御
@export var speed: int = 200 					# 基础速度 用于计算最终的移动速度 velocity

# 成长率，每级增加的属性
@export_group("成长属性")
@export var max_hp_growth: int = 0 				# 最大生命值成长
@export var max_mp_growth: int = 0 				# 最大法力值成长
@export var damage_growth: int = 0 			# 攻击力成长
@export var physical_damage_growth: int = 0 	# 物理攻击力成长
@export var magical_damage_growth: int = 0 	# 魔法攻击力成长
@export var defence_growth: int = 0 			# 防御力成长
@export var physical_defence_growth: int = 0 	# 物理防御力成长
@export var magical_defence_growth: int = 0 	# 魔法防御力成长
@export var speed_growth: int = 0 				# 速度成长

@export_group("","")

# ========================== 虚函数 =============================
func _ready():
	computational_growth_attribute(level)

# ========================== 监听属性更新 ========================
func _set_level (new_level:int) -> void:
	computational_growth_attribute(new_level - level)
	level = new_level

# ========================== 自定义函数 ==========================
# 计算成长属性
func computational_growth_attribute (level_num) -> void:
	if(level_num == 0):
		return

	max_hp += max_hp_growth * level_num
	max_mp += max_mp_growth * level_num
	damage += damage_growth * level_num
	physical_damage += physical_damage_growth * level_num
	magical_damage += magical_damage_growth * level_num
	defence += defence_growth * level_num
	physical_defence += physical_defence_growth * level_num
	magical_defence += magical_defence_growth * level_num
	speed += speed_growth * level_num
