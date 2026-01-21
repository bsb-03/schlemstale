extends CharacterBody2D
class_name Player

#--- EXPORT VARIABLES ---#
@export var max_speed := 70
@export var acceleration := 300
@export var friction := 500

#--- NODE/PATH REFERENCES ---#
@onready var SPRITE = $Sprite
@onready var TEST_TOOL_SCENE = preload("res://Items/Tools/TestTool/test_tool.tscn")
@onready var ATTACK_TIMER = $AttackTimer
const CROSSHAIR = preload("res://UI/crosshair.png")
@onready var INVENTORY_MENU: Control = $CanvasLayer/Inventory


#--- CONTROL VARIABLES ---#
var canAttack := true
var invIsVisible := false

#------#
var inv_array : Array[ItemData] = []
const INV_ARRAY_SIZE = 16
var inv_count : int = 0

func get_class_name() -> String:
	return "Player"

func handle_sprite_flip(v : Vector2):
	if(v.x > 0):
		SPRITE.set_flip_h(false)
	elif (v.x < 0):
		SPRITE.set_flip_h(true)

func move_player(v : Vector2):
	var target_velocity = v * max_speed
	
	if(!target_velocity):
		velocity = velocity.move_toward(Vector2.ZERO, friction * get_physics_process_delta_time())
	else:
		velocity = velocity.move_toward(target_velocity, acceleration * get_physics_process_delta_time())
	
	handle_sprite_flip(velocity)

func get_input():
	var move_input = Input.get_vector("left", "right", "up", "down")
	move_player(move_input)
	
	if(Input.is_action_pressed("use")):
		if(canAttack):
			var mouse_pos := get_global_mouse_position()
			var click_angle = get_angle_to(mouse_pos)
			
			var tts = TEST_TOOL_SCENE.instantiate()
			if(rad_to_deg(click_angle) < -90 || rad_to_deg(click_angle) > 90):
				tts.scale.y = -1
			tts.rotate(click_angle)
			add_child(tts)
			canAttack = false
			ATTACK_TIMER.start()
	if(Input.is_action_just_pressed("toggle_inventory")):
		if(invIsVisible):
			INVENTORY_MENU.hide()
			invIsVisible = false
			return
		
		INVENTORY_MENU.show()
		invIsVisible = true

func _ready() -> void:
	#Input.set_custom_mouse_cursor(CROSSHAIR, Input.CURSOR_ARROW)
	inv_array.resize(INV_ARRAY_SIZE) # fix inv_array to desired size, 16 in this case for every item slot in the inventory
	INVENTORY_MENU.hide()

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()

func _on_hitbox_component_take_knockback(knockbackDirection : Vector2, knockback : float) -> void:
	velocity += knockbackDirection * knockback

func _on_attack_timer_timeout() -> void:
	canAttack = true
