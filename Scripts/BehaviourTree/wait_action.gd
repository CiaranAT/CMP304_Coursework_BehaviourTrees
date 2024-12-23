extends ActionLeaf

enum State {
	ROAMING = 0,
	SEARCHING = 1,
	CHASING = 2
}

var start_wait_time = 0
var wait_time = 0

func tick(actor, _blackboard):

	if start_wait_time == 0:
		start_wait_time = actor.elapsed_time
		

	wait_time =  actor.elapsed_time - 0.75

	if start_wait_time < wait_time:
		
		start_wait_time = 0
		wait_time = 0
		return SUCCESS
	
	if !actor.current_state == State.ROAMING:
		start_wait_time = 0
		wait_time = 0
		return FAILURE
	
	
	return RUNNING
