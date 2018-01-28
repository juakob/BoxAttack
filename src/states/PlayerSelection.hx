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
	
	var playersAvatarsFrames: Array <FlxSprite>;
	var playersAvatarsAlpha: Array <FlxSprite>;
	var playersAvatars: Array <FlxSprite>;
	
	
	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		gamepads = new Array ();
		
		playersAvatarsFrames = new Array();
		playersAvatarsAlpha = new Array();
		playersAvatars = new Array();
		
		
		playersAvatarsFrames.push(new FlxSprite(250, 110, "img/GnoSelectFrame_Blue.png") );
		playersAvatarsFrames.push(new FlxSprite(450, 110, "img/GnoSelectFrame_Red.png") );
		playersAvatarsFrames.push(new FlxSprite(650, 110, "img/GnoSelectFrame_Yellow.png") );
		playersAvatarsFrames.push(new FlxSprite(850, 110, "img/GnoSelectFrame_Green.png") );	
		
		playersAvatarsAlpha.push(new FlxSprite(250, 200, "img/GnoSelect_BlueAlpha.png") );
		playersAvatarsAlpha.push(new FlxSprite(450, 200, "img/GnoSelect_RedAlpha.png") );
		playersAvatarsAlpha.push(new FlxSprite(650, 200, "img/GnoSelect_YellowAlpha.png") );
		playersAvatarsAlpha.push(new FlxSprite(850, 200, "img/GnoSelect_GreenAlpha.png") );
		
		playersAvatars.push(new FlxSprite(250, 200, "img/GnoSelect_Blue.png") );
		playersAvatars.push(new FlxSprite(450, 200, "img/GnoSelect_Red.png") );
		playersAvatars.push(new FlxSprite(650, 200, "img/GnoSelect_Yellow.png") );
		playersAvatars.push(new FlxSprite(850, 200, "img/GnoSelect_Green.png") );
		
		add( playersAvatarsAlpha[0] );
		add( playersAvatarsAlpha[1] );
		add( playersAvatarsAlpha[2] );
		add( playersAvatarsAlpha[3] );
		
		FlxG.sound.playMusic("img/UnicornioAcidez.mp3");
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
					
					//add( playersAvatarsFrames[gamepad.id] );
					
					remove(playersAvatarsAlpha[gamepad.id] );
					
					add( playersAvatarsFrames [gamepad.id] );
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