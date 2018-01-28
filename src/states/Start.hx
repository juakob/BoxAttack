package states;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.gamepad.FlxGamepadInputID;

/**
 * ...
 * @author Joaquin
 */
class Start extends FlxState
{

	public function new() 
	{
		super();
	}
	override public function create():Void 
	{
		add(new FlxSprite(0, 0, "img/StartBackground.png"));
		
		add(new FlxSprite(0, 0, "img/titulo fonteado 3.png"));
		FlxG.sound.playMusic("img/UnicornioAcidezSymph.mp3");
	}
	override public function update(elapsed:Float):Void 
	{
		if (FlxG.gamepads.anyJustPressed(FlxGamepadInputID.START))
		{	
			FlxG.switchState(new Tutorial()); 
		}
		super.update(elapsed);
	}
}