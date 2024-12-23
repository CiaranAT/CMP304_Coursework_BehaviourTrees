extends CharacterBody2D

class_name Enemy

signal target_reached

enum State {
	ROAMING = 0,
	SEARCHING = 1,
	CHASING = 2
}
	
@onready var player = get_node("/root/World/Player")
@onready var navigation_agent = $EnemyNavigation
@onready var enemy_state_sprite = $EnemyStateSprite
@onready var line_of_sight = $LineOfSight
@onready var game_manager = %GameManager

var door_entered_callable = Callable(self, "_door_entered")
var target_location: Vector2:
	get = get_target_location, set = set_target_location
var current_state = State.ROAMING
var current_movement_speed = 175
var base_speed = 200
var roam_speed = 175
var chase_speed = 225
var door_alert_during_search = false
var player_spotted
@export var elapsed_time = 0
@export var time_roaming = 0
@export var time_searching = 0
@export var time_chasing = 0

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
	elif !current_state == State.SEARCHING:
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
			reset_doors()
		State.CHASING:
			current_movement_speed = chase_speed
			enemy_state_sprite.set_frame(2)

func reset_doors():
	for door in get_tree().get_nodes_in_group("door_group"):
		door.door_unchecked = true

func check_lineofsight():
	line_of_sight.look_at(player.global_position)
	if player:
		is_player_in_sight()
		if player_spotted:
			set_state(State.CHASING)

func is_player_in_sight():
	var collider = line_of_sight.get_collider()
	if collider and collider.name == "Player":
		print("This Node2D is the player!")
		player_spotted = true
		print("raycast collided")
		return
	player_spotted = false

func _physics_process(delta: float):
	elapsed_time += 1 * delta
	match current_state:
		State.ROAMING:
			time_roaming += 1 * delta
		State.SEARCHING:
			time_searching += 1 * delta
		State.CHASING:
			time_chasing += 1 * delta
	
	if navigation_agent.is_navigation_finished():
		return

	check_lineofsight()

	var current_agent_position = global_position
	var next_path_position = navigation_agent.get_next_path_position()
	velocity = current_agent_position.direction_to(next_path_position) * current_movement_speed
	
	move_and_slide()

func _on_navigation_agent_2d_target_reached():
	emit_signal("target_reached")
	print("Signal received in Enemy: target reached")


func _on_collision_detection_area_body_entered(body: Node2D):
	if body.name == "Player":
		game_manager.endScreen()
