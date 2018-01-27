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
		return gamepad.anyJustPressed.A;
	}
	
}