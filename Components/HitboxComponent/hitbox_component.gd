extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent

var last_damage_id = 0

signal take_knockback

func damage(d : float, id : int) -> bool:
	if health_component:
		if(last_damage_id != id):
			health_component.damage(d)
			last_damage_id = id
			return true
	return false

func takeKnockback(knockbackDirection : Vector2, knockback : float):
	take_knockback.emit(knockbackDirection, knockback)
