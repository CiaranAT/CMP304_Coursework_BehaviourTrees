using Godot;
using System;

public partial class Flag : Area2D
{
    

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
	{
        GD.Print("flag exists");

        
    }

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}

    private void _on_body_entered(PhysicsBody2D body)
    {
        GD.Print("flag collision");

        GetNode<Player>("%Player").getFlag();

        QueueFree();

    }

}
