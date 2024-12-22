extends ConditionLeaf

enum State {
	ROAMING = 0,
	SEARCHING = 1,
	CHASING = 2
}

func tick(actor, _blackboard):
	if actor.current_state == State.SEARCHING:
		return SUCCESS
	return FAILURE
