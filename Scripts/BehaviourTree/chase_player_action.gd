extends ActionLeaf

enum State {
	ROAMING = 0,
	SEARCHING = 1,
	CHASING = 2
}

func tick(actor, _blackboard):
	
	if actor.player_spotted: #move towards the player every frame while in sight
		actor.target_location = actor.player.global_position
		return RUNNING
	else: #return when enemy loses sight of player
		return SUCCESS
