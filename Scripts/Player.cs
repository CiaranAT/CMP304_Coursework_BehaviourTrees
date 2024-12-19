using Godot;
using System;

public partial class Player : CharacterBody2D
{
	public const float walkSpeed = 200.0f;
	public const float JumpVelocity = -400.0f;
	public bool hasFlag = false;

    public override void _Ready()
    {
        GD.Print("player exists");

		GetNode<Sprite2D>("FlagHoldSprite").Hide();
    }

    public override void _PhysicsProcess(double delta)
	{
		Vector2 velocity = Velocity;
        //// Add the gravity.
        //if (!IsOnFloor())
        //{
        //	velocity += GetGravity() * (float)delta;
        //}

        // Handle Jump.
        if (Input.IsActionJustPressed("ui_accept"))
		{
            velocity.Y = JumpVelocity;
		}

		// Get the input direction and handle the movement/deceleration.
		// As good practice, you should replace UI actions with custom gameplay actions.
		Vector2 direction = Input.GetVector("ui_left", "ui_right", "ui_up", "ui_down");
		if (direction != Vector2.Zero)
		{
			velocity.X = direction.X * walkSpeed;
            velocity.Y = direction.Y * walkSpeed;
        }
		else
		{
			velocity.X = Mathf.MoveToward(Velocity.X, 0, walkSpeed);
            velocity.Y = Mathf.MoveToward(Velocity.Y, 0, walkSpeed);
        }

		Velocity = velocity;
		MoveAndSlide();
	}

	public void getFlag()
	{
		hasFlag = true;
        GD.Print("player gets flag");
        GetNode<Sprite2D>("FlagHoldSprite").Show();
    }
}
