package gameObjects;

import flash.geom.Point;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import gameObjects.TossableImp;
import gameObjects.Tossable;
import io.PlayerInput;

/**
 * ...
 * @author Joaquin
 */
class Player extends FlxSprite
{
	static public inline var MAX_ACCELERATION:Float = 2000;

	var grabedObject:Tossable;
	var knockOutTime:Float=0;
	var KNOCKOUT_TOTALTIME:Float = 1;
	var FLY_SPEED:Float = 2000;
	
	var controller:PlayerInput;
	
	
	public function new(aPlayerInput:PlayerInput,?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		/*makeGraphic(50, 50, FlxColor.fromRGB(50 + Std.int(Math.random() * 200),
											50 + Std.int(Math.random() * 200),
											50+Std.int(Math.random()*200)));*/
		drag.set(1000, 1000);
		maxVelocity.set(400, 400);
		controller = aPlayerInput;
		var tex = FlxAtlasFrames.fromTexturePackerJson("img/Gnomo_Animate.png", "img/Gnomo_Animate.json");
		frames = tex;
		resetFrameSize();
		width = 60;
		offset.x = 25;
		var names:Array<String> = new Array();
		for (i in 0...89) 
		{
			names.push("Gnomo00" + i);
		}
		createAnimation("walkRight", 0, 16, true);
		createAnimation("walkLeft", 17, 33, true);
		createAnimation("walkDown", 34, 42, true);
		createAnimation("walkUp", 43, 51, true);
		createAnimation("idleRight", 52, 60, true);
		createAnimation("idelLeft", 61, 70, true);
		createAnimation("tossRight", 71, 79, false);
		createAnimation("tossLeft", 80, 88, false);
		
		
		
		
	}
	function createAnimation(name:String, from:Int, to:Int,loop:Bool):Void
	{
		var currentFrames:Array<String> = new Array();
		for (i in from...(to+1)) 
		{
			currentFrames.push("Gnomo00" + i);
		}
		animation.addByNames(name, currentFrames, 24,loop);
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
		maxVelocity.set(300, 300);
		drag.set(1000, 1000);
		if (controller.left())
		{
			direcction.x -= 1;
			animation.play("walkLeft");
			
		}
		if (controller.right())
		{
			direcction.x += 1;
			animation.play("walkRight");
		}
		if (controller.up())
		{
			direcction.y -= 1;
			animation.play("walkUp");
		}
		if (controller.down())
		{
			direcction.y += 1;
			animation.play("walkDown");
		}
		if (direcction.length != 0)
		{
			if (direcction.x != 0){
				facing = direcction.x > 0?FlxObject.RIGHT:FlxObject.LEFT;
			}else {
				facing = direcction.y > 0?FlxObject.DOWN:FlxObject.UP;
			}
		}
		if (throwPositionReseted&&(Math.abs(controller.tossX()) >0.5||Math.abs(controller.tossY())>0.5))
		{
			if (grabedObject != null) throwObject();
			throwPositionReseted = false;	
		}else 
		if(Math.abs(controller.tossX()) <0.5&&Math.abs(controller.tossY())<0.5)
		{
			throwPositionReseted = true;	
		}
		direcction.normalize(MAX_ACCELERATION);
		
		acceleration.x = direcction.x;
		acceleration.y = direcction.y;
		super.update(elapsed);
	}
	
	function throwObject() 
	{
		timeInterval = 0;
		if (Math.abs(controller.tossX()) > Math.abs(controller.tossY()))
		{
			if (controller.tossX() > 0)
			{
				grabedObject.toss(1, 0);
			}else {
				grabedObject.toss(-1, 0);
			}
		}else {
			if (controller.tossY() > 0)
			{
				grabedObject.toss(0, 1);
			}else {
				grabedObject.toss(0, -1);
			}
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
		timeInterval = 0;
		acceleration.set(0, 0);
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
	public var score(default,null):Float=0;
	var timeInterval:Float=0;
	var throwPositionReseted:Bool=true;
	public function incrementScore(elapsed:Float) 
	{
		
		timeInterval += elapsed;
		if (timeInterval > 0.5)
		{
			score+= 1;
		}
	}
	
}