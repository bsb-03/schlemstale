extends CharacterBody2D
class_name Player

@export var max_speed := 70
@export var acceleration := 300
@export var friction := 500

@onready var SPRITE = $Sprite
@onready var TEST_TOOL_SCENE = preload("res://Items/Tools/TestTool/test_tool.tscn")

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
	
	if(Input.is_action_just_pressed("use")):
		var mouse_pos := get_global_mouse_position()
		var click_angle = get_angle_to(mouse_pos)
		
		var tts = TEST_TOOL_SCENE.instantiate()
		tts.rotate(click_angle)
		add_child(tts)

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()

func _on_hitbox_component_take_knockback(knockbackDirection : Vector2, knockback : float) -> void:
	velocity += knockbackDirection * knockback
