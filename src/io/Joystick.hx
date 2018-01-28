package io;
import flixel.FlxG;
import flixel.input.gamepad.FlxGamepad;

/**
 * ...
 * @author Joaquin
 */
class Joystick implements PlayerInput
{

	var gamepad:FlxGamepad;
	public function new(aGamepad:FlxGamepad) 
	{
		gamepad = aGamepad;
	}
	
	/* INTERFACE io.PlayerInput */
	
	public function left():Bool 
	{
		return gamepad.analog.value.LEFT_STICK_X < -0.3;
	}
	
	public function right():Bool 
	{
		return gamepad.analog.value.LEFT_STICK_X > 0.3;
	}
	
	public function up():Bool 
	{
		return gamepad.analog.value.LEFT_STICK_Y < -0.3;
	}
	
	public function down():Bool 
	{
		return gamepad.analog.value.LEFT_STICK_Y > .3;
	}
	
	public function toss():Bool 
	{
		return gamepad.justPressed.A;
	}
	
	/* INTERFACE io.PlayerInput */
	
	public function tossX():Float 
	{
		if (gamepad.justPressed.B) return 1;
		if (gamepad.justPressed.X) return -1;
		return 0;
	}
	
	public function tossY():Float 
	{
		if (gamepad.justPressed.Y) return -1;
		if (gamepad.justPressed.A) return 1;
		return 0;
	}
	
}