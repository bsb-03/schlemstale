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
			var c_name = get_parent().get_class_name()
			if(c_name == "WorldObject"):
				get_parent().destroy()
