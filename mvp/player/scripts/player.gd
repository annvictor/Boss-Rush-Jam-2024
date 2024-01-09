extends CharacterBody2D

signal hit # Detecta colisão com inimigos

# Declaração das variáveis de movimento.
@export var spd: int = 64
@export var friction: float = 0.2
@export var acceleration: int = 40
# Declaração das variáveis de animação.
@onready var anim = $AnimationPlayer
@onready var animTree = $AnimationTree

func _ready(): # Função executada automaticamente durante a inicialização da cena.
	pass

func _physics_process(_delta): # Função executada a cada frame de cena.
	var dir = Vector2( # Vetor de direção do objeto, armazena os inputs referentes à movimentação.
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
		)
	
	velocity = dir * spd # Cálculo da velocidade do objeto no ambiente virtual da cena.
	
	if dir.x != 0: # Movimentação horizontal
		pass
	elif dir.y != 0: # Movimentação vertical
		pass
	else: # Parado
		anim.play("idle_down")
		$Sprite.flip_h = dir.x
		$Sprite.flip_v = dir.y
	
	move_and_slide() # Função nativa que atualiza a posição do objeto com base em sua velocidade.


func _on_mouse_shape_entered(shape_idx): # Emite um feedback visual de dano sofrido
	hide() # Objeto desaparece após sofrer dano
	hit.emit()
	
	$CollisionShape2D.set_deferred("disabled", true) # Desativar o formato de colisão da área pode causar um erro se ocorrer no meio do processamento de colisão do motor de jogo. Usar set_deferred() fala para o Godot aguardar para desabilitar a forma até que seja seguro fazê-lo.

func start(pos): # Função responsável por reiniciar/reconfigurar o objeto quando iniciada um nova cena.
	position = pos
	show()
	
	$CollisionShape2D.disabled = false
