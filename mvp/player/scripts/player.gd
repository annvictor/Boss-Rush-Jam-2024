extends CharacterBody2D

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
	var dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = dir * spd # Cálculo da velocidade do objeto no ambiente virtual da cena.
	
	move_and_slide() # Função nativa que atualiza a posição do objeto com base em sua velocidade.
