extends Node3D

var control_points = []
#objetos visiveis em cena
@onready var curve_things: Node3D = $curve_things
@onready var test_cube: Node3D = $Test_Cube
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

#Variaveis visiveis no inspetor
enum types {bezier, linear}
@export var selected_type: types
@export var line_segments: int

var total_control_points: int
var time = 0

#variavel que permite pausar ou retomar o movimento do cubo
var paused = true

#Na função ready será preparado a visualização do caminho e preparação dos pontos de controle em array
func _ready() -> void:
	#Adiciona os pontos de controle em um array
	for child in curve_things.get_children():
		control_points.append(child.global_position)
		total_control_points += 1
	
	#Gera as esferas do caminho
	generate_spheres(line_segments)
		

#Função de interpolação linear
func linear(t):
	var segments = total_control_points - 1
	var scaled_t = t * segments
	var segment_index = int(scaled_t)
	
	if segment_index >= segments:
		segment_index = segments -1
	#O tempo é escalado para a quantidade de segmentos, permitindo interpolação individual entre as posições
	var local_t = scaled_t - segment_index
	
	return control_points[segment_index].lerp(control_points[segment_index + 1], local_t)

#Função de interpolação de curva de bezier
func ready_curve(t):
	var points = control_points
	
	#prepara a interpolação dos pontos individualmente e os guarda em um array
	while len(points) > 1:
		var new_points = []
		for i in range(len(points) - 1):
			var interpolated = points[i].lerp(points[i + 1], t)
			new_points.append(interpolated)
		points = new_points
	return points[0]

func _physics_process(delta: float) -> void:
	
	#seleção de curva de bezier
	if selected_type == 0:
		if paused == false:
			#prepara a curva 
			test_cube.global_position = ready_curve(time)
			#envia o cubo através do caminho 
			time += delta
			#reseta a posição do cubo em relação ao tempo através de "time"
			if time >= 1:
				time = 0
				
	elif selected_type == 1:
		if paused == false:
			#prepara o caminho linear
			test_cube.global_position = linear(time)
			#envia o cubo através do caminho 
			time += delta
			#reseta a posição do cubo em relação ao tempo através de "time"
			if time >= 1:
				time = 0
	
	#detecta o imput da barra de espaço para pausar ou despausar o progresso do cubo
	if Input.is_action_just_pressed("ui_accept"):
		if paused == true:
			paused = false
		else:
			paused = true

func get_point_at_time(t: float) -> Vector3:
	match selected_type:
		types.bezier:
			return ready_curve(t)
		types.linear:
			return linear(t)
	return Vector3.ZERO

#gera as esferas no caminho
func generate_spheres(count: int):

	for i in range(count):
		#Calcula a distribuição das esferas em t
		var sample_t: float = float(i) / float(count - 1)
		#utiliza de sample_t para pegar uma posição no caminho onde uma esfera deve ser colocada
		var sphere_position: Vector3 = get_point_at_time(sample_t)
		
		#duplica a mesh original como uma nova instancia 
		var new_sphere: MeshInstance3D = mesh_instance_3d.duplicate() as MeshInstance3D
		add_child(new_sphere)
		
		#posiciona a nova esfera na posição adequada
		new_sphere.global_position = sphere_position
		new_sphere.visible = true
