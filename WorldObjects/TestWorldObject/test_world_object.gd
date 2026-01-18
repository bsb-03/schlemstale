extends StaticBody2D
class_name WorldObject


@onready var TEST_ITEM = preload("res://Items/Materials/TestItem/test_item.tscn")

func get_class_name()-> String:
	return "WorldObject"
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func destroy():
	var dropped_item = TEST_ITEM.instantiate()
	dropped_item.position = position
	remove_child(dropped_item)
	get_parent().add_sibling(dropped_item)
	queue_free()
