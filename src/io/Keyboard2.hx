package io;
import flixel.FlxG;

/**
 * ...
 * @author Joaquin
 */
class Keyboard2 implements PlayerInput
{

	public function new() 
	{
		
	}
	
	/* INTERFACE IO.PlayerInput */
	
	public function left():Bool 
	{
		return FlxG.keys.pressed.A;
	}
	
	public function right():Bool 
	{
		return FlxG.keys.pressed.D;
	}
	
	public function up():Bool 
	{
		return FlxG.keys.pressed.W;
	}
	
	public function down():Bool 
	{
		return FlxG.keys.pressed.S;
	}
	
	public function toss():Bool 
	{
		return FlxG.keys.justPressed.R;
	}
		
	public function tossX():Float 
	{
		return 0;
	}
	
	public function tossY():Float 
	{
		return 0;
	}
}