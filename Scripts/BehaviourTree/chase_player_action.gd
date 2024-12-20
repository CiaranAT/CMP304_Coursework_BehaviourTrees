extends ActionLeaf


#func tick(actor: Node, blackboard: Blackboard) -> int:
	#return SUCCESS

var target_reached = false

func _target_reached():
	self.target_reached = true
	print("target reached signal")

var callable = Callable(self, "_target_reached")

func tick(actor, _blackboard):
	if !actor.is_connected("target_reached", _target_reached):
		actor.connect("target_reached", _target_reached)

	if target_reached:
		target_reached = false
		actor.disconnect("target_reached", _target_reached)
		return SUCCESS
	
	if !target_reached:
		return RUNNING

#func tick(actor, _blackboard):
	#if not actor.is_connected("target_reached", self, "_target_reached"):
		#actor.connect("target_reached", self, "_target_reached")
		#actor.reset()
	#if self.target_reached:
		#self.target_reached = false
		#actor.disconnect("target_reached", self, "_target_reached")
		#return SUCCESS
	#actor.set_target_location(actor.target.global_postion)
	#return RUNNING
