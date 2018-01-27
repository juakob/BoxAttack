package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.input.gamepad.FlxGamepadInputID;

import flixel.input.gamepad.FlxGamepad;

/**
 * ...
 * @author Gonza V ...
 */
class PlayerSelection extends FlxState 
{
	
	var gamepads: Array <Int>;
	
	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		gamepads = new Array ();
		
		//debug
		FlxG.log.redirectTraces = true;	
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		
		var activeGamepads = FlxG.gamepads.getActiveGamepads();
		
		for ( gamepad in activeGamepads)
		{
			if (gamepad.justPressed.A)
			{
				if ( gamepads.indexOf( gamepad.id ) ==-1)
				{
					gamepads.push(gamepad.id);	
					
					//debug
					trace (gamepad.id);
					
				}
			} 
			
		}
		
		if (FlxG.gamepads.anyJustPressed( FlxGamepadInputID.START)&& gamepads.length >= 2 )
		{
			FlxG.switchState( new GameState(gamepads) );
		}
	}
	
	
}