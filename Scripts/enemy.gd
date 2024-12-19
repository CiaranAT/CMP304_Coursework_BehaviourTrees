class_name Enemy
extends CharacterBody2D

var movement_speed = 210.0
@export var target: Node2D = null

@onready var navigation_agent = $NavigationAgent2D

func _ready():
	call_deferred("path_finding_setup")
	pass #replace

func path_finding_setup():
	await get_tree().physics_frame
	if target:
		navigation_agent.target_position = target.global_position

#func accquire_target:
	

func _physics_process(delta: float):
	if navigation_agent.is_navigation_finished():
		return
	
	if target:
		navigation_agent.target_position = target.global_position
	
	var current_agent_position = global_position
	var next_path_position = navigation_agent.get_next_path_position()
	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	
	move_and_slide()
	pass
