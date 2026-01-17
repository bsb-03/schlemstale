extends Node2D
class_name TestTool

@onready var anim_player = $AnimationPlayer
@onready var hurtbox = $Sprite/HurtboxComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_player.play("test_tool_swing")

func _physics_process(delta: float) -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
