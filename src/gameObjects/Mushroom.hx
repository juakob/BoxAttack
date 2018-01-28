package gameObjects;
import flixel.group.FlxGroup;

/**
 * ...
 * @author Joaquin
 */
class Mushroom extends TossableImp
{

	var explosion:FlxGroup;
	public function new(?X:Float=0, ?Y:Float=0,explosions:FlxGroup) 
	{
		super(X, Y);
		loadGraphic("img/mushroom.png", true, 70, 70);
		
		animation.add("grow", [0, 1, 2, 3], 12, false);
		reGrow();
		explosion = explosions;
	}
	override function reGrow() 
	{
		super.reGrow();
		animation.play("grow");
	}
	override public function bounce():Void 
	{
		var explosion:MushroomExplosion = cast this.explosion.recycle(MushroomExplosion);
		explosion.reset(x, y);
		super.bounce();
	}
	
}