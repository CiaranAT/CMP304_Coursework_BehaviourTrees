extends ActionLeaf

enum State {
	ROAMING = 0,
	SEARCHING = 1,
	CHASING = 2
}

func tick(actor, _blackboard):
	
	if actor.player_spotted:
		actor.target_location = actor.target.global_position
		return RUNNING
	else:
		actor.set_state(State.SEARCHING)
		return SUCCESS
