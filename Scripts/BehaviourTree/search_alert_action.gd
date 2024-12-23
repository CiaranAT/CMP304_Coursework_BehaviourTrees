extends ActionLeaf

enum State {
	ROAMING = 0,
	SEARCHING = 1,
	CHASING = 2
}

var target_reached = false

func _target_reached():
	self.target_reached = true
	print("Signal received in SearchDoorAlertAction: target_reached")

var target_reached_callable = Callable(self, "_target_reached")

func tick(actor, _blackboard):
	if !actor.is_connected("target_reached", _target_reached):
		actor.connect("target_reached", _target_reached)
		actor.target_location = actor.player.global_position
	
	if target_reached:
		target_reached = false
		if actor.current_state == State.CHASING:
			actor.set_state(State.SEARCHING)
		else:
			actor.set_state(State.ROAMING)
		actor.disconnect("target_reached", _target_reached)
		return SUCCESS
	
	if actor.door_alert_during_search or actor.player_spotted:
		actor.target_location = actor.player.global_position
		actor.door_alert_during_search = false
		return FAILURE
	
	if !target_reached:
		return RUNNING
