extends Area2D
class_name HurtboxComponent

@export var DAMAGE := 10
@export var PIERCE := 1
@export var KNOCKBACK := 10.0

var damage : int
var pierce : int
var knockback : float

func _ready():
	damage = DAMAGE
	pierce = PIERCE
	knockback = KNOCKBACK

func _physics_process(delta: float) -> void:
	if has_overlapping_areas():
		var areas = get_overlapping_areas()
		for a in areas:
			if a.has_method("damage"):
				if(a.damage(damage, get_instance_id())):
					pierce = pierce - 1
				if pierce == 0:
					get_parent().queue_free()
			if a.has_method("takeKnockback"):
				var knockbackDirection : Vector2 = (a.get_global_position() - get_global_position()).normalized()
				a.takeKnockback(knockbackDirection, knockback)
