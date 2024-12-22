extends ActionLeaf

enum State {
	ROAMING = 0,
	SEARCHING = 1,
	CHASING = 2
}

var door_selected = false
var target_reached = false

func _target_reached():
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
				actor.target_location = door.global_position
				shortest_distance = door_distance
				selected_door = door
				door_selected = true;
	
	if selected_door:
		print("door selected in Roaming Action")
		selected_door.door_unchecked = false;
	

func tick(actor, _blackboard):
	
	if !actor.is_connected("target_reached", _target_reached):
		actor.connect("target_reached", _target_reached)

	if target_reached:
		target_reached = false
		door_selected = false
		actor.disconnect("target_reached", _target_reached)
		return SUCCESS

	if !door_selected:
		_select_door(actor)
		
		if !door_selected:
			actor._reset_doors()
			return FAILURE
	
	if !actor.current_state == State.ROAMING:
		return FAILURE
	
	if !target_reached:
		return RUNNING
