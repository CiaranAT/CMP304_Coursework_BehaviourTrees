extends ActionLeaf

enum State {
	ROAMING = 0,
	SEARCHING = 1,
	CHASING = 2
}

var target_reached = false

func _target_reached_chase(current_state):
	if current_state == State.CHASING:
		self.target_reached = true
		print("Signal received in SearchPlayerAction: target_reached")

var target_reached_callable = Callable(self, "_target_reached")

func tick(actor, _blackboard):
	if !actor.is_connected("target_reached", _target_reached_chase):
		actor.connect("target_reached", _target_reached_chase)
		actor.target_location = actor.player.global_position
	
	if target_reached:
		target_reached = false
		actor.set_state(State.SEARCHING)
		actor.disconnect("target_reached", _target_reached_chase)
		actor.target_location = actor.player.global_position
		return SUCCESS
	
	if actor.player_spotted:
		actor.door_alert_during_search = false
		return FAILURE
	
	if !target_reached:
		return RUNNING
