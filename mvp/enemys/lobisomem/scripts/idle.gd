extends State

@onready var collision = $"../../DetectionArea/CollisionArea"
@onready var progressBar = owner.find_child("TextureProgressBar")

var player_entered: bool = false:
	set(value):
		player_entered = value
		collision.set_deferred("disabled", value)
		progressBar.set_deferred("visible", value)

func transition():
	if player_entered:
		get_parent().change_state("Chase")

func _on_detection_area_body_entered(body):
	player_entered = true
