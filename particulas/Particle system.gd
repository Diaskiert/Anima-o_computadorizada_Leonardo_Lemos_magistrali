extends GPUParticles2D
@onready var gpu_particles_2d: GPUParticles2D = $"."

var particle_mat = null
var random_color
var new_curve = null


func _ready() -> void:
	particle_mat = gpu_particles_2d.process_material
	change_mode(0)

func _process(delta: float) -> void:
	#Controle de modos. Detecta inputs do teclado e muda os modos de emissão de particulas
	
	#Modo de estrelas coloridas sem gravidade com fade out
	if Input.is_action_just_pressed("Type 1"):
		change_mode(0)
	
	#Modo de estrelas em turbilhão. Giro em orbita e morte por velocidade de giro angular
	if Input.is_action_just_pressed("Type 2"):
		change_mode(1)
	
	#Modo cascata de estrelas. Estrelas aumentam de tamanho e desaparecem por tempo fora da tela
	if Input.is_action_just_pressed("Type 3"):
		change_mode(2)
	
	#Para ou continua a execução de qualquer modo de particulas
	if Input.is_action_just_pressed("Pause"):
		if gpu_particles_2d.emitting == true:
			gpu_particles_2d.emitting = false
		else:
			gpu_particles_2d.emitting = true
			
#Função change_mode(mode) aciona os diferentes tipos de modos de particula
func change_mode(mode: int):
	#Se o modo for 0...
	if mode == 0:
		print("mode is 0") #Confirmação via console
		gpu_particles_2d.amount = 10 #quantidade de particulas: 10
		gpu_particles_2d.lifetime = 5 #duração de particulas: 5 segundos
		particle_mat.lifetime_randomness = 1.0 #Particulas podem durar de 0 á 5 segundos
		particle_mat.emission_shape_scale = Vector3(250,250,250) #Tamanho da area de emissão aumentado em 250X
		particle_mat.emission_shape = 3 #Emissões em formato de caixa
		particle_mat.gravity = Vector3(0,0,0) #Sem gravidade
		particle_mat.direction = Vector3(0,0,0) #Sem movimento
		particle_mat.scale = Vector2(0.5, 2.0) #Escala variavel de particula entre 0.5x e 2x 
		particle_mat.hue_variation = Vector2(-1,1) #Variação total de cores (qualquer tom)
		particle_mat.angle = Vector2(-72, 720) #Angulo aleatorio entre -72 e 720 graus
		particle_mat.orbit_velocity = Vector2(0,0) #Sem velocidade orbital
		particle_mat.radial_velocity = Vector2(0,0) #Sem velocidade radial
		particle_mat.direction = Vector3(0,0,0) #sem direção
		particle_mat.spread = 0 #Particulas não se espalham de seu ponto inicial
		particle_mat.initial_velocity = Vector2(0,0) #Sem velocidade inicial
		particle_mat.angular_velocity = Vector2(0,0) #Sem velocidade angular
		
		var gradient = Gradient.new() #Criar um novo gradiente
		gradient.set_color(0.0, Color(1,1,1,1)) #Cor na posição 0.0 do gradiente = Branco
		gradient.set_color(1.0, Color(1,1,1,0)) #Cor na posição 1.0 do gradiente = Transparente
		var gradient_Texture = GradientTexture1D.new() #Cria nova textura de gradiente
		gradient_Texture.gradient = gradient #Seta novo gradiente como textura
		particle_mat.color_ramp = gradient_Texture #Particulas ficam transparentes quanto mais passa seu life time
		
		particle_mat.scale_curve = null #Particulas não mudam de tamanho
		particle_mat.angular_velocity_curve = null #Particulas não rotacionam

		#Particulas aparecem aleatoriamente dentro de uma area retangular e com rotação aleatoria
		
		
	elif mode == 1:
		#Se o modo for 1...
		print("mode is 1") #Confirmação via console
		gpu_particles_2d.amount = 20 #quantidade de particulas: 20
		gpu_particles_2d.lifetime = 2.5 #duração de particulas: 2.5 segundos
		particle_mat.lifetime_randomness = 0.5 #Particulas podem durar de 1.25 á 2.5 segundos
		particle_mat.emission_shape_scale = Vector3(250,250,250) #Tamanho da area de emissão aumentada em 250x
		particle_mat.emission_shape = 1 #Area de emissão em formato de circulo
		particle_mat.scale = Vector2(0.5, 0.5) #Escala de 0.5x 
		particle_mat.gravity = Vector3(0,0,0) #Gravidade desligada
		particle_mat.orbit_velocity = Vector2(-1,1.5) #velocidade orbital entre -1 e 1.5
		particle_mat.radial_velocity = Vector2(-1,1) #Velocidade orbital entre -1 e 1
		particle_mat.angle = Vector2(0, 0) #Angulo sem modificação
		particle_mat.hue_variation = Vector2(0,0) #Sem variação de cor
		particle_mat.color = Color.from_rgba8(255,255,0,255) #Cor amarela para todas as estrelas
		particle_mat.direction = Vector3(0,0,0) #Sem direção de movimento inicial
		particle_mat.spread = 0 #Particulas não se espalham de seu ponto inicial
		particle_mat.initial_velocity = Vector2(0,0) #Sem velocidade inicial
		particle_mat.angular_velocity = Vector2(0,100) #Velocidade angular entre 0 e 100
		
		var velocity_curve = CurveTexture.new() #Cria nova textura de curva
		var new_curve = Curve.new()#Cria nova curva 
		new_curve.clear_points()#Limpa os pontos da curva par evitar mudanças não desejadas
		new_curve.add_point(Vector2(0,0),0,0,Curve.TANGENT_FREE,Curve.TANGENT_FREE) #Adiciona um ponto no inicio da curva
		new_curve.add_point(Vector2(1,1),0,0,Curve.TANGENT_FREE,Curve.TANGENT_FREE) #Adiciona um ponto no fim da curva
		velocity_curve.curve = new_curve #Adiciona a curva como textura
		particle_mat.angular_velocity_curve = velocity_curve #Utiliza a textura de curva para aumentar a velocidade angular das particulas com o tempo
		
		particle_mat.color_ramp = null #Sem mudança de cor 
		particle_mat.scale_curve = null #sem mudança de tamanho
		
		#Particulas giram em diferentes velocidades em orbita e rotacionam sobre seus proprios eixos antes de deseparecerem
		
	elif mode == 2:
		#Se o modo for 2...
		print("mode is 2")  #Confirmação via console
		gpu_particles_2d.amount = 300 #Quantidade de particulas: 300
		gpu_particles_2d.lifetime = 5 #Duração de particula: 5 segundos
		particle_mat.lifetime_randomness = 0 #Particulas duram a mesma quantidade de tempo
		particle_mat.emission_shape_scale = Vector3(250,250,250) #Tamanho da area de emissão aumentada em 250x
		particle_mat.emission_shape = 0 #Area de emissão em formato de ponto
		particle_mat.gravity = Vector3(0,200,0) #Sem gravidade
		particle_mat.orbit_velocity = Vector2(0,0) #Sem velocidade orbital
		particle_mat.radial_velocity = Vector2(100,200) #Sem velocidade radial
		particle_mat.angle = Vector2(0, 0) #Angulo inicial fixo em 0
		particle_mat.hue_variation = Vector2(0,0)# Sem variação de cor
		particle_mat.color = Color.from_rgba8(0,255,255,255) #Cor inicial: Ciano
		particle_mat.direction = Vector3(0,-500,0) # Direção inicial: -500
		particle_mat.spread = 45 #Espalhamento de 45 graus
		particle_mat.initial_velocity = Vector2(50,100) #Velocidade inicial entre 50 e 100
		particle_mat.angular_velocity = Vector2(-50,50) #Velocidade angular inicial entre -50 e 50
		particle_mat.scale = Vector2(0.5, 0.75) #Escala variavel entre 0.5x e 0.75x
		particle_mat.color_ramp = null #Sem mudança de cor
		
		var scale_curve = CurveTexture.new() #Cria nova textura de curva
		var curve = Curve.new() #Cria nova curva
		curve.clear_points() #Limpa os pontos da curva par evitar mudanças não desejadas
		curve.add_point(Vector2(0,0),0,0,Curve.TANGENT_FREE,Curve.TANGENT_FREE) #Adiciona um ponto no inicio da curva
		curve.add_point(Vector2(1,1),0,0,Curve.TANGENT_FREE,Curve.TANGENT_FREE) #Adiciona um ponto no fim da curva
		scale_curve.curve = curve #Adiciona a curva como textura
		particle_mat.scale_curve = scale_curve #Utiliza a textura de curva para aumentar o tamanho das particulas com o tempo
		
		particle_mat.angular_velocity_curve = null #Sem mudança de velocidade angular
		
		#Particulas surgem pequenas e aumentam de tamanho com o passar do tempo no formato de uma cascata ou chafariz
