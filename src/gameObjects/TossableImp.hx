package gameObjects;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import gameObjects.Player;

/**
 * ...
 * @author Joaquin
 */
class TossableImp extends FlxSprite implements Tossable
{
	static public inline var MAX_VELOCIY:Float = 1000;
	private var player:Player;
	var flying:Bool;
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(30, 30, FlxColor.RED);
		elasticity = 0.3;
	}
	override public function update(elapsed:Float):Void 
	{
		if (player != null&&!flying)
		{
			x = player.x;
			y = player.y;
		}
		super.update(elapsed);
	}
	
	
	
	/* INTERFACE gameObjects.Tossable */
	
	public function toss(aX:Float,aY:Float):Void 
	{
		flying = true;
		velocity.x = aX * MAX_VELOCIY;
		velocity.y = aY * MAX_VELOCIY;
		allowCollisions = FlxObject.ANY;
		
		if (aX > 0)
		{
			facing = FlxObject.RIGHT;
		}else
		if (aX < 0)
		{
			facing = FlxObject.LEFT;
		}else
		if (aY > 0)
		{
			facing = FlxObject.DOWN;
		}else
		if (aY < 0)
		{
			facing = FlxObject.UP;
		}
		drag.set(0, 0);
	}
	
	public function grab(aPlayer:Player):Bool 
	{
		if (!flying||aPlayer==player)
		{
			allowCollisions = FlxObject.NONE;
			player = aPlayer;
			return true;
		}
		return false;
	}
	
	/* INTERFACE gameObjects.Tossable */
	
	public function bounce():Void 
	{
		flying = false;
		player = null;
		/*velocity.x =velocity.x;
		velocity.y =velocity.y;*/
		drag.set(300, 300);
	}
	
	/* INTERFACE gameObjects.Tossable */
	
	public function drop():Void 
	{
		allowCollisions = FlxObject.ANY;
		player = null;
		flying = false;
		velocity.set(0, 0);
	}
	
	/* INTERFACE gameObjects.Tossable */
	
	public function isOnAir():Bool 
	{
		return flying;
	}
}