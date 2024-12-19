using Godot;
using System;

public partial class MainMenu : CanvasLayer
{
    PackedScene world1 = (PackedScene)GD.Load("res://Scenes/GameScenes/world.tscn");
    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}

    public void _on_play_1_button_down()
	{
        GetTree().ChangeSceneToPacked(world1);
    }
}
