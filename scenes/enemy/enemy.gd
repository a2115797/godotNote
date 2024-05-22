extends CharacterBody2D

func _ready():
	$Area2D.area_entered.connect(on_area_entered)

func _process(_delta):
	move_and_slide()

func on_area_entered(_other_area: Area2D):
	queue_free()
