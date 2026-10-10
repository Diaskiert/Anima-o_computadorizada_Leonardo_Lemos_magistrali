extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var cube: MeshInstance3D = $Cube

func _ready() -> void:
	animation_player.play("Cube_001Action")
	print("play")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("replaying")
	animation_player.play("Cube_001Action")

func pause_animation():
	print("pause")
	animation_player.pause()

func continue_playing():
	print("continue")
	animation_player.play("Cube_001Action")
	
func tween_transitions(propriedade: String, destino: float, duracao: float):
	if not animation_player.is_playing() and cube:
		var tween = create_tween()
		tween.tween_property(cube, propriedade,destino, duracao)#.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
