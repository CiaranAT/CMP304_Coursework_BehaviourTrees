extends ConditionLeaf


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func tick(actor, _blackboard):
	if actor.completed_your_action:
		return SUCCESS
	return FAILURE
