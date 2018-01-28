package states;

import flixel.FlxG;
import flixel.FlxSprite;
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
	
	var playersAvatars: Array <FlxSprite>;
	
	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		gamepads = new Array ();
		
		playersAvatars = new Array();
	
		playersAvatars.push(new FlxSprite(280, 250, "img/GnoAvatar_Blue.png") );
		playersAvatars.push(new FlxSprite(480, 250, "img/GnoAvatar_Red.png") );
		playersAvatars.push(new FlxSprite(680, 250, "img/GnoAvatar_Yellow.png") );
		playersAvatars.push(new FlxSprite(880, 250, "img/GnoAvatar_Green.png") );
		
		
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
					
					add( playersAvatars[gamepad.id] );
					

				}
			} 
			
		}
		
		if (FlxG.gamepads.anyJustPressed( FlxGamepadInputID.START)&& gamepads.length >= 2 )
		{
			FlxG.switchState( new GameState(gamepads) );
		}
	}
	
	
}