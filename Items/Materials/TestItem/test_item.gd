extends Node2D

@export var item_resource : ItemResource

@onready var GRAVITY_AREA = $GravityArea
@onready var PICKUP_AREA = $PickupArea

var item_name : String
var item_type : String
var stack_amt : int
var item_path : String

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
	item_name = item_resource.name
	item_type = item_resource.type
	stack_amt = item_resource.stack_amt
	item_path = item_resource.item_path

func _physics_process(delta: float) -> void:
	check_pickup()
	gravitate_toward_player()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
