#controls if the roaming sequence should start
extends ConditionLeaf

enum State {
	ROAMING = 0,
	SEARCHING = 1,
	CHASING = 2
}

func tick(actor, _blackboard):
	if actor.current_state == State.ROAMING:
		return SUCCESS
	return FAILURE
