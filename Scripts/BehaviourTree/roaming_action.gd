extends ActionLeaf

enum State {
	ROAMING = 0,
	SEARCHING = 1,
	CHASING = 2
}

var door_selected = false
var target_reached = false

func _target_reached_roam(current_state):
	if current_state == State.ROAMING:
		self.target_reached = true
		print("Signal received in RoamingSequenceAction: target_reached")

var callable = Callable(self, "_target_reached")

func _select_door(actor: Node):
	
	var selected_door
	var door_distance
	var shortest_distance = 9999999
	
	for door in get_tree().get_nodes_in_group("door_group"):
		if door.door_unchecked:
			
			door_distance = actor.global_position.distance_to(door.global_position)
			if door_distance < shortest_distance:
				shortest_distance = door_distance
				selected_door = door
				door_selected = true;
	
	if selected_door:
		actor.target_location = selected_door.global_position
		print("door selected in Roaming Action")
		selected_door.door_unchecked = false;
		target_reached = false
	

func tick(actor, _blackboard):
	
	if !actor.is_connected("target_reached", _target_reached_roam):
		actor.connect("target_reached", _target_reached_roam)

	if !door_selected:
		_select_door(actor)
		
		if !door_selected:
			actor.reset_doors()
			actor.disconnect("target_reached", _target_reached_roam)
			return FAILURE

	if target_reached:
		target_reached = false
		door_selected = false
		actor.disconnect("target_reached", _target_reached_roam)
		return SUCCESS

	if !actor.current_state == State.ROAMING:
		door_selected = false
		actor.disconnect("target_reached", _target_reached_roam)
		return FAILURE
	
	if !target_reached:
		actor.disconnect("target_reached", _target_reached_roam)
		return RUNNING
