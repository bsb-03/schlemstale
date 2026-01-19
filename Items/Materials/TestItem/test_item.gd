extends Node2D

@onready var GRAVITY_AREA = $GravityArea
@onready var PICKUP_AREA = $PickupArea

func gravitate_toward_player():
	if(GRAVITY_AREA.has_overlapping_bodies()):
		var bodies = GRAVITY_AREA.get_overlapping_bodies()
		for b in bodies:
			if(b.has_method("get_class_name")):
				if(b.get_class_name() == "Player"):
					position = lerp(position, b.position, .03)

func check_pickup():
	if(PICKUP_AREA.has_overlapping_bodies()):
		var bodies = PICKUP_AREA.get_overlapping_bodies()
		for b in bodies:
			if(b.has_method("get_class_name")):
				if(b.get_class_name() == "Player"):
					queue_free()
					# do something else here

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	check_pickup()
	gravitate_toward_player()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
