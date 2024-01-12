extends CharacterBody2D

var spd = 32
var player_chase = false
var player = null

func _physics_process(_delta):
	if player_chase:
		position += (player.position - position)/spd
		$AnimatedSprite.play("walk_right")
	else:
		$AnimatedSprite.play("idle")

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

func _on_detection_area_body_exited(_body):
	player = null
	player_chase = false
