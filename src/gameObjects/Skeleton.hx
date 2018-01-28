package gameObjects;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Joaquin
 */
class Skeleton extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		var tex = FlxAtlasFrames.fromTexturePackerJson("img/end.png", "img/end.json");
		frames = tex;
		resetFrameSize();
		var names:Array<String> = new Array();
		for (i in 0...33) 
		{
			names.push("Esqueleto_gnoclope00" + i);
		}
		animation.addByNames("dance",names,24);
		animation.play("dance");
	}
	
}