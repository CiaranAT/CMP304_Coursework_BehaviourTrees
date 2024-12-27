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

var callable = Callable(self, "_target_reached")

func _select_door(actor: Node): #selects the nearest "unchecked" door and selects it to travel to
	
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
		selected_door.door_unchecked = false;
		target_reached = false
	

#roams between doors by selecting the nearest door and marking it as checked when visited
#when all doors are visited they will be reset
func tick(actor, _blackboard):
	
	#connect navigation path end reached signal to this node
	if !actor.is_connected("target_reached", _target_reached_roam):
		actor.connect("target_reached", _target_reached_roam)

	#select a door to travel to if not already selected
	if !door_selected:
		_select_door(actor)
		
		if !door_selected: #reset "checked" doors when all doors are checked
			actor.reset_doors()
			actor.disconnect("target_reached", _target_reached_roam)
			return FAILURE

	if target_reached: #select a new door when door is reached
		target_reached = false
		door_selected = false
		actor.disconnect("target_reached", _target_reached_roam)
		return SUCCESS

	#change state when player is spotted or door triggered by player
	if !actor.current_state == State.ROAMING:
		door_selected = false
		actor.disconnect("target_reached", _target_reached_roam)
		return FAILURE
	
	if !target_reached:
		return RUNNING
