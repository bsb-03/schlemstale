extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 10
var health : int


func _ready() -> void:
	health = MAX_HEALTH

func damage(d : float):
	health -= d
	
	if health <= 0:
		get_parent().queue_free()
