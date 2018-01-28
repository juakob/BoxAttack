package gameObjects;
import flixel.FlxG;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import gameObjects.Player;
import openfl.Assets;

/**
 * ...
 * @author Joaquin
 */
class Head extends TossableImp
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(1280/2, 720/2);
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
	override public function grab(aPlayer:Player):Bool 
	{
		var sndPath:String = new String ("img/Gnome" + Std.int(Math.random() * 7 + 1) + ".mp3"); 
		FlxG.sound.play(sndPath);
		return super.grab(aPlayer);
	}
}