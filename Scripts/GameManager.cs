using Godot;
using System;

public partial class GameManager : Node
{
	public bool gamevictory = false;

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}

	public void doorOpenAlert()
	{
        GD.Print("door collision alert");
    }

	public void exitCollision()
	{
        if (GetNode<Player>("%Player").hasFlag)
		{
            gamevictory = true;

            GD.Print("exit collision alert");

            endScreen();
        }

    }

	public void endScreen()
	{
		GetTree().Paused = true;

        GetNode<GameEndScreen>("%GameEndScreen").Show();
    }
}
