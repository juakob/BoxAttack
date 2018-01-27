package gameObjects;

import flash.geom.Point;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import gameObjects.TossableImp;
import gameObjects.Tossable;
import io.PlayerInput;

/**
 * ...
 * @author Joaquin
 */
class Player extends FlxSprite
{
	static public inline var MAX_ACCELERATION:Float = 1500;

	var grabedObject:Tossable;
	var knockOutTime:Float=0;
	var KNOCKOUT_TOTALTIME:Float = 1;
	var FLY_SPEED:Float = 2000;
	
	var controller:PlayerInput;
	
	
	public function new(aPlayerInput:PlayerInput,?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(50, 50);
		drag.set(1000, 1000);
		maxVelocity.set(300, 300);
		controller = aPlayerInput;
	}
	
	override public function update(elapsed:Float):Void 
	{
		var direcction:Point = new Point();
		knockOutTime-= elapsed;
		if (knockOutTime > 0) {
			drag.set(0, 0);
			maxVelocity.set(20000, 20000);
			elasticity = 0.1;
			super.update(elapsed);
			return;
		}
		elasticity = 0;
		maxVelocity.set(200, 200);
		drag.set(1000, 1000);
		if (controller.left())
		{
			direcction.x -= 1;
			
		}
		if (controller.right())
		{
			direcction.x += 1;
		}
		if (controller.up())
		{
			direcction.y -= 1;
		}
		if (controller.down())
		{
			direcction.y += 1;
		}
		if (direcction.length != 0)
		{
			if (direcction.x != 0){
				facing = direcction.x > 0?FlxObject.RIGHT:FlxObject.LEFT;
			}else {
				facing = direcction.y > 0?FlxObject.DOWN:FlxObject.UP;
			}
		}
		if (controller.toss())
		{
			if(grabedObject!=null) throwObject();
		}
		direcction.normalize(MAX_ACCELERATION);
		
		acceleration.x = direcction.x;
		acceleration.y = direcction.y;
		super.update(elapsed);
	}
	
	function throwObject() 
	{
		if(facing==FlxObject.UP){
			grabedObject.toss(0,-1);
		}else
		if (facing == FlxObject.DOWN) {
			grabedObject.toss(0,1);
		}else
		if (facing == FlxObject.RIGHT) {
			grabedObject.toss(1,0);
		}else
		if (facing == FlxObject.LEFT) {	
			grabedObject.toss(-1,0);
		}
		grabedObject = null;
	}
	
	public function grabHead(head:Tossable) 
	{
		grabedObject = head;
	}
	public function grabObject(object:Tossable)
	{
		grabedObject = object;
	}
	
	public function knockOut(object:Tossable) 
	{
		knockOutTime = KNOCKOUT_TOTALTIME;
		if(grabedObject!=null){
			grabedObject.drop();
			grabedObject = null;
		}
		if (object.facing == FlxObject.LEFT)
		{
			velocity.set(-FLY_SPEED, 0);
		}else
		if (object.facing == FlxObject.RIGHT)
		{
			velocity.set(FLY_SPEED, 0);
		}else
		if (object.facing == FlxObject.UP)
		{
			velocity.set(0, -FLY_SPEED);
		}else
		if (object.facing == FlxObject.DOWN)
		{
			velocity.set(0, FLY_SPEED);
		}
		
	}
	
	public function isKnockOut():Bool 
	{
		return knockOutTime > 0;
	}
	
	public function hasRock() 
	{
		return grabedObject != null;
	}
	
}