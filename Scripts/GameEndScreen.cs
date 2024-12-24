using Godot;
using System;

public partial class GameEndScreen : CanvasLayer
{
    //ready main menu to change to
	PackedScene main_menu = (PackedScene)GD.Load("res://Scenes/GameScenes/main_menu.tscn");
    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
	{
		this.Hide();
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{

	}

    public void _on_main_menu_button_down()
	{
		//return to main menu
        this.Hide();
        GetTree().Paused = false;
        GetTree().ChangeSceneToPacked(main_menu);
    }
}
