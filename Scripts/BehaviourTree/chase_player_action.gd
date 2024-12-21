extends ActionLeaf

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
		print(actor.name)
		actor.disconnect("target_reached", _target_reached)
		return SUCCESS
	
	#if actor is Enemy:
		#print("This is an Enemy:", actor.name)
	
	actor.target_location = actor.target.global_position
	#actor.test_print()
	
	#print(type_string(typeof(actor)))
	
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
