extends CharacterBody2D

class_name Enemy

signal target_reached

enum State {
	ROAMING = 0,
	SEARCHING = 1,
	CHASING = 2
}

@export var target: Node2D = null
@export var player: Node2D = null
@export var target_location: Vector2:
	get = get_target_location, set = set_target_location
	
@onready var navigation_agent = $NavigationAgent2D
@onready var enemy_state_sprite = $EnemyStateSprite
@onready var game_manager = get_node("/root/World/GameManager")

var door_entered_callable = Callable(self, "_door_entered")
var current_state = State.ROAMING
var current_movement_speed = 175
var base_speed = 200
var roam_speed = 175
var chase_speed = 250
var door_alert_during_search = false

func _ready():
	
	if game_manager:
		print("GameManager found")
	else:
		print("GameManager not found")
	
	call_deferred("connect_signal")
	

func connect_signal():
	print("connect signal call in enemy")
	if game_manager.has_signal("DoorEntered"):
		game_manager.connect("DoorEntered", _door_entered)
		print("Signal 'door_entered' found on GameManager.")
	else:
		print("Signal 'door_entered' not found on GameManager.")

func _door_entered():
	print("Signal received in Enemy: door_entered")
	if current_state == State.SEARCHING:
		door_alert_during_search = true
	else:
		set_state(State.SEARCHING)

func get_target_location():
	return target_location

func set_target_location(value):
	target_location = value
	if navigation_agent != null:
		navigation_agent.target_position = target_location

func set_state(new_state):
	current_state = new_state
	
	match current_state:
		State.ROAMING:
			enemy_state_sprite.set_frame(0)
			current_movement_speed = roam_speed
		State.SEARCHING:
			current_movement_speed = base_speed
			enemy_state_sprite.set_frame(1)
		State.CHASING:
			current_movement_speed = chase_speed
			enemy_state_sprite.set_frame(2)


func _physics_process(delta: float):
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position = global_position
	var next_path_position = navigation_agent.get_next_path_position()
	velocity = current_agent_position.direction_to(next_path_position) * current_movement_speed
	
	move_and_slide()

func _on_navigation_agent_2d_target_reached():
	emit_signal("target_reached")
	print("Signal received in Enemy: target reached")
