package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import gameObjects.TossableImp;
import gameObjects.Player;
import gameObjects.Tossable;
import io.Keyboard1;
import io.Keyboard2;

/**
 * ...
 * @author Joaquin
 */
class GameState extends FlxState
{

	public function new() 
	{
		super();
	}
	var players:FlxGroup;
	var throwables:FlxGroup;
	var head:TossableImp;
	var walls:FlxGroup;
	var rocks:FlxGroup;
	
	override public function create():Void 
	{
		players = new FlxGroup();
		throwables = new FlxGroup();
		 var player = new Player(new Keyboard1(),100, 100);
		add(player);
		players.add(player);
		 player = new Player(new Keyboard2(),400, 100);
		add(player);
		players.add(player);
		head = new TossableImp(500, 500);
		add(head);
		throwables.add(head);
		
		rocks = new FlxGroup();
		var rock:TossableImp = new TossableImp(1280 - 100, 600);
		rocks.add(rock);
		throwables.add(rock);
		add(rock);
		
		
		
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
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		FlxG.collide(players, head, playerVsHead);
		FlxG.collide(players, rocks, playerVsRocks);
		FlxG.collide(walls, players);
		FlxG.collide(walls, throwables,throwableVsWall);
		
	}
	
	function playerVsRocks(player:Player,object:Tossable) 
	{
		if(!player.isKnockOut()&&object.grab(player)){
			player.grabHead(object);
		}else {
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