using Godot;
using System;

public partial class MainMenu : CanvasLayer
{
    //get scenes ready to change to
    PackedScene world1 = (PackedScene)GD.Load("res://Scenes/GameScenes/world.tscn");
    PackedScene world2 = (PackedScene)GD.Load("res://Scenes/GameScenes/world2.tscn");
    PackedScene world3 = (PackedScene)GD.Load("res://Scenes/GameScenes/world3.tscn");
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

    public void _on_play_2_button_down()
    {
        GetTree().ChangeSceneToPacked(world2);
    }

    public void _on_play_3_button_down()
    {
        GetTree().ChangeSceneToPacked(world3);
    }
}



