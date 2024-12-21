using Godot;
using System;

public partial class GameManager : Node
{
	public bool gamevictory = false;

    //public partial class MyNode2D : Node2D
    //{
    //    [Signal]
    //    public delegate void DoorEntered();
    //}

    [Signal]
    public delegate void DoorEnteredEventHandler();

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
        EmitSignal(SignalName.DoorEntered);
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
