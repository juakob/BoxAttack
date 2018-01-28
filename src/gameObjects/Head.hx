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
		scale.set(0.9, 0.9);
		offset.set(5, 24);
		var tex = FlxAtlasFrames.fromTexturePackerJson("img/Unicorn.png", "img/Unicorn.json");
		frames = tex;
		resetFrameSize();
		width = 70;
		height = 70;
		var names:Array<String> = new Array();
		for (i in 0...8) 
		{
			names.push("mc_hcabeza000" + i);
		}
		animation.addByNames("loop", names, 24);
		animation.play("loop");
		
	}
	override public function bounce():Void 
	{
		flying = false;
		player = null;
		/*velocity.x =velocity.x;
		velocity.y =velocity.y;*/
		drag.set(300, 300);
	}
	
}