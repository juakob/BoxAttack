package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import gameObjects.Head;
import gameObjects.TossableImp;
import gameObjects.Player;
import gameObjects.Tossable;
import io.Joystick;
import io.Keyboard1;
import io.Keyboard2;
import io.PlayerInput;

/**
 * ...
 * @author Joaquin
 */
class GameState extends FlxState
{

	var joystickId:Array<Int>;
	public function new(joysitcks:Array<Int>=null) 
	{
		joystickId = joysitcks;
		super();
	}
	var players:FlxGroup;
	var throwables:FlxGroup;
	var head:Head;
	var walls:FlxGroup;
	var rocks:FlxGroup;
	var scores:Array<FlxText>;
	
	override public function create():Void 
	{
		players = new FlxGroup();
		throwables = new FlxGroup();
		rocks = new FlxGroup();
		scores = new Array();
		
		
		var counter:Int = 0;
		for (gamepadId in joystickId) 
		{
			createPlayer(100, 100, new Joystick(FlxG.gamepads.getByID(gamepadId)), counter);
			++counter;
		}
		for (i in 0...(joystickId.length+2)) 
		{
			createRock();
			var text = new FlxText(100 + (1180 / 4) * i, 50, 100, "0", 20);
			scores.push(text);
			add(text);
			
		}
		


		head = new Head(500, 500);
		add(head);
		throwables.add(head);
		
		
		walls = new FlxGroup();
		var left = new FlxSprite( -10, 0);
		left.width = 10;
		left.height = 720;
		left.immovable = true;
		walls.add(left);
		
		var right = new FlxSprite( 1280, 0);
		right.width = 10;
		right.height = 720;
		right.immovable = true;
		walls.add(right);
		
		var top = new FlxSprite( -10, -10);
		top.width = 1280+20;
		top.height = 10;
		top.immovable = true;
		walls.add(top);
		
		var down = new FlxSprite( -10, 720);
		down.width = 1280+20;
		down.height = 10;
		down.immovable = true;
		walls.add(down);
	}
	
	function createRock() 
	{
		var rock:TossableImp = new TossableImp(100+Math.random()*1000,100+Math.random()*500);
		rocks.add(rock);
		throwables.add(rock);
		add(rock);
	}
	function createPlayer(aX:Float, aY:Float, controller:PlayerInput,aId:Int)
	{
		var player = new Player(controller, aX, aY);
		player.ID=aId;
		add(player);
		players.add(player);
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		FlxG.collide(players, head, playerVsHead);
		FlxG.collide(players, rocks, playerVsRocks);
		FlxG.collide(walls, players);
		FlxG.collide(walls, throwables, throwableVsWall);
		
		if (head.player != null)
		{
			head.player.incrementScore(elapsed);
			scores[head.player.ID].text = head.player.score+"";
		}
		
	}
	
	function playerVsRocks(player:Player,object:Tossable) 
	{
		if(!player.hasRock()&&!player.isKnockOut()&&object.grab(player)){
			player.grabHead(object);
		}else
		if(object.isOnAir())
		 {
			player.knockOut(object);
			object.bounce();
		}
	}
	
	function throwableVsWall(wall:FlxSprite,rock:Tossable) 
	{
		rock.bounce();
	}
	
	public function playerVsHead(player:Player,object:Tossable) 
	{
		playerVsRocks(player, object);
		
	}
	
}