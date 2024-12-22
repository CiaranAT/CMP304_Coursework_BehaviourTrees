extends Node

var game_victory = false

signal door_entered

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func doorOpenAlert():
	print("door collision alert");
	emit_signal("door_entered")
	
func exitCollision():
	if player.hasFlag:
		game_victory = true
		print("exit collision alert");

func endScreen():
	get_tree().paused = true
	#get_node("GameEndScreen")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
