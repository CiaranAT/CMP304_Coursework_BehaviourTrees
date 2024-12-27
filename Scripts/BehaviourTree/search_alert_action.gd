extends ActionLeaf

enum State {
	ROAMING = 0,
	SEARCHING = 1,
	CHASING = 2
}

var target_reached = false

func _target_reached_search(current_state):
	if current_state == State.SEARCHING:
		self.target_reached = true

var target_reached_callable = Callable(self, "_target_reached")

#travel to the players location when alerted, alerts are triggered when a door is collided or chasing has ended
func tick(actor, _blackboard):
	#connect navigation path end reached signal to this node
	if !actor.is_connected("target_reached", _target_reached_search):
		actor.connect("target_reached", _target_reached_search)
		actor.target_location = actor.player.global_position
	
	#if nothing is found then return to roaming
	if target_reached:
		target_reached = false
		actor.set_state(State.ROAMING)
		actor.disconnect("target_reached", _target_reached_search)
		return SUCCESS
	
	#reset the behaviour tree when a door is triggered or player is spotted
	if actor.door_alert_during_search or actor.current_state == State.CHASING:
		actor.target_location = actor.player.global_position
		actor.door_alert_during_search = false
		actor.disconnect("target_reached", _target_reached_search)
		return FAILURE
	
	if !target_reached:
		return RUNNING
