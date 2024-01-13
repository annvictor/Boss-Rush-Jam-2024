extends Node

@onready var hp_point = $hpPoint
var max_hp = 5
var hp
var hp_sprites = []

func _ready():
	hp = max_hp
	spawn_hp_sprites()

func spawn_hp_sprites():
	# Limpar sprites existentes, caso haja algum
	for sprite in hp_sprites:
		sprite.queue_free()
	hp_sprites.clear()

	# Instanciar novos sprites com base na variável hp
	for life in range(hp):
		var new_hp_sprite = hp_point.instance()
		hp_sprites.append(new_hp_sprite)
		add_child(new_hp_sprite)

func take_damage(damage):
	hp -= damage
	hp = max(0, hp)  # Garante que o hp não seja negativo
	update_hp_sprites()

func update_hp_sprites():
	# Atualizar o número de sprites com base no valor atual de hp
	var diff = hp_sprites.size() - hp
	if diff > 0:
		# Remover sprites extras se o hp diminuiu
		for i in range(diff):
			var sprite = hp_sprites.pop_back()
			sprite.queue_free()
	elif diff < 0:
		# Adicionar sprites extras se o hp aumentou
		for i in range(abs(diff)):
			var new_hp_sprite = hp_point.instance()
			hp_sprites.append(new_hp_sprite)
			add_child(new_hp_sprite)









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
