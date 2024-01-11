extends Node

func _ready(): # Função executada automaticamente durante a inicialização da cena.
	pass

func _process(delta): # Função executada a cada frame de cena
	pass

func _physics_process(delta): # Função executada a cada frame de cena
	pass
	
	'''
	Se você estiver lidando com lógica de jogo 
	que não depende diretamente da física, como 
	animações ou lógica de jogo em tempo real, 
	_process(delta) é a escolha apropriada. 
	Por outro lado, se estiver trabalhando com 
	lógica que envolve física, como movimentação 
	suave ou interações de colisão, 
	_physics_process(delta) é mais apropriado, 
	pois garante uma taxa de chamada constante em 
	relação à física do jogo.
	'''
