extends CharacterBody2D

# 生物基类，拥有生物的基础特性如生命、攻击力、防御力、移动度等
@export var level : int = 0 # 等级
@export var exp : int = 0 # 经验值 experience point
@export var max_hp : int = 1 # 最大生命值
@export var hp : int = 1 # 当前生命值 hit_points

@export var max_mp : int = 0 # 最大法力值
@export var mp : int = 0 # 当前法力值 mana_points

@export var damage : int = 0 # 攻击力
@export var physical_damage : int = 0 # 物理攻击力
@export var magical_damage : int = 0 # 魔法攻击力
@export var defence : int = 0 # 防御力
@export var physical_defence : int = 0 # 物理防御
@export var magical_defence : int = 0 # 法术防御
@export var speed : int = 0 # 基础速度 用于计算最终的移动速度 velocity

# 成长率，每级增加的属性
@export var max_hp_growth : int = 0 # 最大生命值成长
@export var max_mp_growth : int = 0 # 最大法力值成长
@export var damage_growth : int = 0 # 攻击力成长
@export var physical_damage_growth : int = 0 # 物理攻击力成长
@export var magical_damage_growth : int = 0 # 魔法攻击力成长
@export var defence_growth : int = 0 # 防御力成长
@export var physical_defence_growth : int = 0 # 物理防御力成长
@export var magical_defence_growth : int = 0 # 魔法防御力成长
@export var speed_growth : int = 0 # 速度成长

# 监听等级更新
func _set_level (newLevel:int):
	var num = newLevel - level 
	max_hp += max_hp * num
	max_mp += max_mp * num
	damage += damage * num
	physical_damage += physical_damage * num
	magical_damage += magical_damage * num
	defence += defence * num
	physical_defence += physical_defence * num
	magical_defence += magical_defence * num
	speed += speed * num
	
