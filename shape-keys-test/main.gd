extends Node3D

var is_playing = true
@onready var shape_keys_test: Node3D = $"Shape keys test"
var shape_controler = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if is_playing:
			shape_keys_test.pause_animation()
			is_playing = false
		else:
			shape_keys_test.continue_playing()
			is_playing = true
	if not is_playing:
		
		if Input.is_action_just_pressed("Shape key 1"):
			if shape_controler[0] == 0.0:
				shape_keys_test.tween_transitions("blend_shapes/Eyes appear", 1.0, 2.0)
				shape_controler[0] = 1.0
			elif shape_controler[0] > 0.0:
				shape_keys_test.tween_transitions("blend_shapes/Eyes appear", 0.0, 2.0)
				shape_controler[1] = 0.0
			
		if Input.is_action_just_pressed("Shape key 2"):
			if shape_controler[1] == 0.0:
				shape_keys_test.tween_transitions("blend_shapes/Mouth appear", 1.0, 2.0)
				shape_controler[1] = 1.0
			elif shape_controler[1] > 0.0:
				shape_keys_test.tween_transitions("blend_shapes/Mouth appear", 0.0, 2.0)
				shape_controler[1] = 0.0
			
		if Input.is_action_just_pressed("Shape key 3"):
			if shape_controler[2] == 0.0:
				shape_keys_test.tween_transitions("blend_shapes/Ears", 1.0, 2.0)
				shape_controler[2] = 1.0
			elif shape_controler[2] > 0.0:
				shape_keys_test.tween_transitions("blend_shapes/Ears", 0.0, 2.0)
				shape_controler[2] = 0.0
			
		if Input.is_action_just_pressed("Shape key 4"):
			if shape_controler[3] == 0.0:
				shape_keys_test.tween_transitions("blend_shapes/Left knee curl", 1.0, 2.0)
				shape_controler[3] = 1.0
			elif shape_controler[3] > 0.0:
				shape_keys_test.tween_transitions("blend_shapes/Left knee curl", 0.0, 2.0)
				shape_controler[3] = 0.0
			
		if Input.is_action_just_pressed("Shape key 5"):
			if shape_controler[4] == 0.0:
				shape_keys_test.tween_transitions("blend_shapes/Right knee curl", 1.0, 2.0)
				shape_controler[4] = 1.0
			elif shape_controler[4] > 0.0:
				shape_keys_test.tween_transitions("blend_shapes/Right knee curl", 0.0, 2.0)
				shape_controler[4] = 0.0
			
		if Input.is_action_just_pressed("Shape key 6"):
			if shape_controler[5] == 0.0:
				shape_keys_test.tween_transitions("blend_shapes/Left arm lift", 1.0, 2.0)
				shape_controler[5] = 1.0
			elif shape_controler[5] > 0.0:
				shape_keys_test.tween_transitions("blend_shapes/Left arm lift", 0.0, 2.0)
				shape_controler[5] = 0.0
