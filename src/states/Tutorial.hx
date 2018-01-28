package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.gamepad.FlxGamepadInputID;

/**
 * ...
 * @author Joaquin
 */
class Tutorial extends FlxState
{

	public function new() 
	{
		super();
	}
	override public function create():Void 
	{
		var sndPath:String = new String ("img/Gnome" + Std.int(Math.random() * 7 + 1) + ".mp3"); 
		FlxG.sound.play(sndPath);
		
		add(new FlxSprite(0, 0, "img/tutorial.png"));
		
	}
	var timer:Float = 0;
	
	override public function update(elapsed:Float):Void 
	{
		timer += elapsed;
		if (timer >10) {
			FlxG.switchState(new PlayerSelection()); 
		}
		if (FlxG.gamepads.anyJustPressed(FlxGamepadInputID.A))
		{	
			FlxG.switchState(new PlayerSelection()); 
		}
		super.update(elapsed);
	}
}