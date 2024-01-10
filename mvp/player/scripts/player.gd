extends CharacterBody2D

signal hit # Detecta colisão com inimigos.

# Declaração das variáveis de movimento.
@export var spd = 64
@export var friction = 0.8
@export var acceleration = 0.4
# Declaração das variáveis de animação.
@onready var anim = $AnimationPlayer
@onready var animTree = $AnimationTree

func _ready(): # Função executada automaticamente durante a inicialização da cena.
	pass

func _physics_process(_delta): # Função executada a cada frame de cena.
	move()
	move_and_slide() # Função nativa que atualiza a posição do objeto com base em sua velocidade.

func move(): # Função de movimentação do objeto.
	var dir = Vector2( # Vetor de direção do objeto, armazena os inputs referentes à movimentação.
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
		)
	
	if dir.x > 0: # Movimentação para a direita.
		anim.play("walk_right")
	elif dir.x < 0: # Movimentação para a esquerda.
		anim.play("walk_left")
	elif dir.y > 0: # Movimentação para cima.
		anim.play("walk_up")
	elif dir.y < 0: # Movimentação para baixo.
		anim.play("walk_down")
	else: # Parado.
		anim.play("idle_down")
	
	if dir != Vector2.ZERO:
		velocity.x = lerp(velocity.x, dir.x * spd, acceleration) # Cálculo da velocidade do objeto no eixo horizontal.
		velocity.y = lerp(velocity.y, dir.y * spd, acceleration) # Cálculo da velocidade do objeto no eixo vertical.
		return
	
	velocity.x = lerp(velocity.x, dir.x * spd, friction) # Cálculo da desaceleração do objeto no eixo horizontal.
	velocity.y = lerp(velocity.y, dir.y * spd, friction) # Cálculo da desaceleração do objeto no eixo vertical.

func _on_mouse_shape_entered(shape_idx): # Emite um feedback visual de dano sofrido.
	hide() # Objeto desaparece após sofrer dano.
	hit.emit()
	
	$CollisionShape2D.set_deferred("disabled", true) # Desativar o formato de colisão da área pode causar um erro se ocorrer no meio do processamento de colisão do motor de jogo. Usar set_deferred() fala para o Godot aguardar para desabilitar a forma até que seja seguro fazê-lo.

func start(pos): # Função responsável por reiniciar/reconfigurar o objeto quando iniciada um nova cena.
	position = pos
	show()
	
	$CollisionShape2D.disabled = false
