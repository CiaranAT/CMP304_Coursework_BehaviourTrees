extends ActionLeaf

var door_selected = false

var target_reached = false

func _target_reached():
	self.target_reached = true
	print("target reached signal")

var callable = Callable(self, "_target_reached")

func _select_door(actor: Node):
	##var door_group = get_tree().get_nodes_in_group("door_group")[0]
	##var doors = door_group.get_children()
	##
	##if doors
	
	var all_doors_checked = true
	
	for door in get_tree().get_nodes_in_group("door_group"):
		if door.door_unchecked:
			print("door selected")
			actor.target_location = door.global_position
			door.door_unchecked = false;
			door_selected = true;
			return
			
		

func tick(actor, _blackboard):
	
	if !actor.is_connected("target_reached", _target_reached):
		actor.connect("target_reached", _target_reached)
		

	if target_reached:
		target_reached = false
		door_selected = false
		print(actor.name)
		actor.disconnect("target_reached", _target_reached)
		return SUCCESS

	if !door_selected:
		_select_door(actor)
		
		# no close tree available right now!
		#if closest_tree == null:
			#return FAILURE
	
	if !target_reached:
		return RUNNING
