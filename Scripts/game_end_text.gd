extends RichTextLabel

@onready var game_manager = $"/root/World/GameManager"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if game_manager:
		print("game manager found in GameEndScreen")
	else:
		print("NO game manager found in GameEndScreen")
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_game_end_screen_visibility_changed():
	
	bbcode_enabled = true
	if visible and game_manager:
		if game_manager.gamevictory:
			text = "[center][b][color=green]GAME VICTORY[/color][/b][/center]"
		else:
			text = "[center][b][color=red]GAME OVER[/color][/b][/center]"
