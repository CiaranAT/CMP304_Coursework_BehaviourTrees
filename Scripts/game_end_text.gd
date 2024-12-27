extends RichTextLabel

@onready var game_manager = $"/root/World/GameManager"

var total_time = 0
var total_time_roaming = 0
var total_time_searching = 0
var total_time_chasing = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_game_end_screen_visibility_changed():
	
	bbcode_enabled = true
	
	if visible and game_manager:
		total_time = String("%.3f" % game_manager.elapsed_time)
		total_time_roaming = String("%.3f" % game_manager.time_roaming)
		total_time_searching = String("%.3f" % game_manager.time_searching)
		total_time_chasing = String("%.3f" % game_manager.time_chasing)
		
		if game_manager.gamevictory:
			text = "[center][b][color=green]GAME VICTORY[/color][/b]
			\nTotal Time: " + str(total_time) + "s
			\nRoaming Time: " + str(total_time_roaming) + "s
			\nSearching Time: " + str(total_time_searching) + "s
			\nChasing Time: " + str(total_time_chasing) + "s[/center]"
		else:
			text = "[center][b][color=red]GAME OVER[/color][/b]
			\nTotal Time: " + str(total_time) + "s
			\nRoaming Time: " + str(total_time_roaming) + "s
			\nSearching Time: " + str(total_time_searching) + "s
			\nChasing Time: " + str(total_time_chasing) + "s[/center]"
