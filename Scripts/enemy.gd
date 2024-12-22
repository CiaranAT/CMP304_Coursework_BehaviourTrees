extends CharacterBody2D

class_name Enemy

signal target_reached

enum States {
	PASSIVE = 0,
	ALERT = 1,
	CHASING = 2
}

var movement_speed = 210.0
@export var target: Node2D = null
@export var player: Node2D = null
@export var target_location: Vector2:
	get = get_target_location, set = set_target_location

@onready var navigation_agent = $NavigationAgent2D
@onready var game_manager = get_node("/root/World/GameManager")

var door_entered_callable = Callable(self, "_door_entered")

func _ready():
	
	if game_manager:
		print("GameManager found")
	else:
		print("GameManager not found")
	
	print(game_manager.get_signal_list())
	call_deferred("path_finding_setup")
	
	call_deferred("connect_signal")
	

func connect_signal():
	if game_manager.has_signal("DoorEntered"):
		game_manager.connect("DoorEntered", _door_entered)
		print("Signal 'door_entered' found!!!!!.")
	else:
		print("Signal 'door_entered' not found on GameManager.")

func _door_entered():
	print("Signal received in Enemy: door_entered")

func path_finding_setup():
	await get_tree().physics_frame
	if target:
		#navigation_agent.target_position = target.global_position
		set_target_location(target.global_position)

func get_target_location():
	return target_location

func set_target_location(value):
	target_location = value
	if navigation_agent != null:
		navigation_agent.target_position = target_location

func test_print():
	print("enemy function test print")
	return

func _physics_process(delta: float):
	if navigation_agent.is_navigation_finished():
		return
	
	#if target:
		#navigation_agent.target_position = target.global_position
	

	
	var current_agent_position = global_position
	var next_path_position = navigation_agent.get_next_path_position()
	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	
	move_and_slide()
	pass


func _on_navigation_agent_2d_target_reached():
	emit_signal("target_reached")
	print("target reached")
