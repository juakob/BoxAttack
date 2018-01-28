package gameObjects;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Joaquin
 */
class MushroomExplosion extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic("img/mushroomExplosion.png", true, 90, 90);
		animation.add("explosion", [0, 1, 2, 3, 4, 5], 30, false);
	}
	override public function reset(X:Float, Y:Float):Void 
	{
		super.reset(X, Y);
		animation.play("explosion");
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (animation.finished)
		{
			kill();
		}
	}
}