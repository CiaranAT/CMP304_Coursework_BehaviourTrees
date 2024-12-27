using Godot;
using System;

public partial class Player : CharacterBody2D
{
	public const float walkSpeed = 200.0f;
	public const float JumpVelocity = -400.0f;
	public bool hasFlag = false;

    public override void _Ready()
    {
		GetNode<Sprite2D>("FlagHoldSprite").Hide();
    }

    public override void _PhysicsProcess(double delta)
	{
		Vector2 velocity = Velocity;

		// Get the input direction and handle the movement/deceleration.
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

	public void getFlag() //attach flag to player
    {
		hasFlag = true;
        GetNode<Sprite2D>("FlagHoldSprite").Show();
    }
}
