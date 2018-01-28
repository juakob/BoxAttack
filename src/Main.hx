package;

import flixel.FlxGame;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.Event;
import states.GameState;
import states.PlayerSelection;
import states.Start;

/**
 * ...
 * @author Joaquin
 */
class Main extends Sprite 
{

	public function new() 
	{
		super();
		
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);
		addChild(new FlxGame(1280, 720, Start));
		//addChild(new FlxGame(1280, 720, GameState));
	}

}
