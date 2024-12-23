using Godot;
using System;

public partial class GameManager : Node
{
	public bool gamevictory = false;

    public float elapsed_time = 0;


    [Signal]
    public delegate void DoorEnteredEventHandler();

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
	{
        // Ensure the signal is registered
        if (!HasSignal(SignalName.DoorEntered))
        {
            AddUserSignal(SignalName.DoorEntered);
        }
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
// elapsed_time = GetNode<GameEndScreen>("%Enemy").elapsed_time


        GetTree().Paused = true;

        GetNode<GameEndScreen>("%GameEndScreen").Show();
    }
}
