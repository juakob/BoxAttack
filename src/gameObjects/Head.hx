package gameObjects;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.Assets;

/**
 * ...
 * @author Joaquin
 */
class Head extends TossableImp
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		var tex = FlxAtlasFrames.fromTexturePackerJson("img/Gnocople.png", "img/Gnocople.json");
		frames = tex;
		resetFrameSize();
		var names:Array<String> = new Array();
		for (i in 0...8) 
		{
			names.push("mc_hcabeza000" + i);
		}
		animation.addByNames("loop", names, 24);
		animation.play("loop");
		
	}
	
}