extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 10
var health : int


func _ready() -> void:
	health = MAX_HEALTH

func damage(d : float):
	health -= d
	
	if health <= 0:
		if(get_parent().has_method("get_class_name")):
			if(get_parent().get_class_name() == "WorldObject"):
				get_parent().destroy()
