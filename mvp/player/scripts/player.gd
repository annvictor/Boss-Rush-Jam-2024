extends CharacterBody2D

signal hit # Detecta colisão com inimigos.

# Declaração das variáveis de movimento.
var dir = Vector2.ZERO
@export var spd = 128
@export var friction = 0.8
@export var acceleration = 0.4
# Declaração das variáveis de animação.
@onready var animTree: AnimationTree = $AnimationTree

func _ready(): # Função executada automaticamente durante a inicialização da cena.
	animTree.active = true

func _physics_process(_delta): # Função executada a cada frame de cena.
	move()
	update_animation()
	move_and_slide() # Função nativa que atualiza a posição do objeto com base em sua velocidade.

func move(): # Função de movimentação do objeto.
	dir = Input.get_vector("move_left", "move_right", "move_up", "move_down") # Vetor de direção do objeto, armazena os inputs referentes à movimentação.
	
	if dir != Vector2.ZERO:
		velocity.x = lerp(velocity.x, dir.normalized().x * spd, acceleration) # Cálculo da velocidade do objeto no eixo horizontal.
		velocity.y = lerp(velocity.y, dir.normalized().y * spd, acceleration) # Cálculo da velocidade do objeto no eixo vertical.
		return
	
	velocity.x = lerp(velocity.x, dir.normalized().x * spd, friction) # Cálculo da desaceleração do objeto no eixo horizontal.
	velocity.y = lerp(velocity.y, dir.normalized().y * spd, friction) # Cálculo da desaceleração do objeto no eixo vertical.

func update_animation(): # Função que atualiza a animação do sprite.
	if velocity.length() > 10:
		animTree["parameters/conditions/is_moving"] = true
		animTree["parameters/conditions/idle"] = false
	else:
		animTree["parameters/conditions/is_moving"] = false
		animTree["parameters/conditions/idle"] = true
	
	if dir != Vector2.ZERO:
		animTree["parameters/idle/blend_position"] = dir
		animTree["parameters/walk/blend_position"] = dir

func _on_mouse_shape_entered(_shape_idx): # Emite um feedback visual de dano sofrido.
	hide() # Objeto desaparece após sofrer dano.
	hit.emit()
	
	$CollisionShape2D.set_deferred("disabled", true) # Desativar o formato de colisão da área pode causar um erro se ocorrer no meio do processamento de colisão do motor de jogo. Usar set_deferred() fala para o Godot aguardar para desabilitar a forma até que seja seguro fazê-lo.

func start(pos): # Função responsável por reiniciar/reconfigurar o objeto quando iniciada um nova cena.
	position = pos
	show()
	
	$CollisionShape2D.disabled = false
