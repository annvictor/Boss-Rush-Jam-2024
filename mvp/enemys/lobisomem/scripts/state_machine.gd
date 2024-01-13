extends Node2D

var currentState: State
var previousState: State

func _ready():
	currentState = get_child(0) as State
	previousState = currentState
	currentState.enter()

func change_state(state):
	currentState = find_child(state) as State
	currentState.enter()
	
	previousState.exit()
	previousState = currentState
