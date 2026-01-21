extends Panel

@onready var grid_container: GridContainer = $MarginContainer/GridContainer

const HAND_CLOSED = preload("res://UI/hand_closed.png")
const HAND_OPEN = preload("res://UI/hand_open.png")

func _ready() -> void:
	# set inventory cursors
	Input.set_custom_mouse_cursor(HAND_OPEN, Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(HAND_CLOSED, Input.CURSOR_FORBIDDEN)
	Input.set_custom_mouse_cursor(HAND_CLOSED, Input.CURSOR_CAN_DROP)
	Input.set_custom_mouse_cursor(HAND_CLOSED, Input.CURSOR_DRAG)

var data_bk
func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_DRAG_BEGIN:
		data_bk = get_viewport().gui_get_drag_data()
	if what == Node.NOTIFICATION_DRAG_END:
		if not is_drag_successful():
			if data_bk:
				data_bk.icon.show()
				data_bk = null

func _on_player_item_picked_up(item_data : ItemData) -> void:
	var slots := grid_container.get_children()
	for s in slots:
		if s.item == null:
			s.item = item_data
			s.update_ui()
			break
