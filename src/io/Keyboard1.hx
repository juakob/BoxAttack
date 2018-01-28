package io;
import flixel.FlxG;

/**
 * ...
 * @author Joaquin
 */
class Keyboard1 implements PlayerInput
{

	public function new() 
	{
		
	}
	
	/* INTERFACE IO.PlayerInput */
	
	public function left():Bool 
	{
		return FlxG.keys.pressed.LEFT;
	}
	
	public function right():Bool 
	{
		return FlxG.keys.pressed.RIGHT;
	}
	
	public function up():Bool 
	{
		return FlxG.keys.pressed.UP;
	}
	
	public function down():Bool 
	{
		return FlxG.keys.pressed.DOWN;
	}
	
	public function toss():Bool 
	{
		return FlxG.keys.justPressed.SHIFT;
	}
	
	/* INTERFACE io.PlayerInput */
	
	public function tossX():Float 
	{
		return 0;
	}
	
	public function tossY():Float 
	{
		return 0;
	}
	
}