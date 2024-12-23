using Godot;
using System;

public partial class GameEndScreen : CanvasLayer
{
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

    //public void InitMenu(double delta)
    //{
    //    this.Show();
    //}

    public void _on_main_menu_button_down()
	{
        this.Hide();
        GetTree().Paused = false;
        GetTree().ChangeSceneToPacked(main_menu);
    }
}
