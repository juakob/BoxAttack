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
		add(new FlxSprite(0, 0, "img/titulo fonteado 3.png"));
	}
	override public function update(elapsed:Float):Void 
	{
		if (FlxG.gamepads.anyJustPressed(FlxGamepadInputID.START))
		{
			FlxG.switchState(new PlayerSelection()); 
		}
		super.update(elapsed);
	}
}