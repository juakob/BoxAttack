package states;

import flash.geom.Point;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.text.FlxText;
import gameObjects.Head;
import gameObjects.Mushroom;
import gameObjects.Skeleton;
import gameObjects.TossableImp;
import gameObjects.Player;
import gameObjects.Tossable;
import io.Joystick;
import io.Keyboard1;
import io.Keyboard2;
import io.PlayerInput;
import openfl.geom.ColorTransform;

/**
 * ...
 * @author Joaquin, Gonzalo V
 */
class GameState extends FlxState
{

	var joystickId:Array<Int>;
	
	var players:FlxGroup;
	var throwables:FlxGroup;
	var head:Head;
	var walls:FlxGroup;
	var rocks:FlxGroup;
	var scores:Array<FlxText>;
	var player:Player;
	var explosions:FlxGroup;
	
	var playersAvatars: Array <FlxSprite>;
	var skeleton:gameObjects.Skeleton;
	
	public function new(joysitcks:Array<Int>=null) 
	{
		joystickId = joysitcks;
		super();
	}
	
	override public function create():Void 
	{
		FlxG.sound.playMusic("img/UnicornioAcidez.mp3");
		players = new FlxGroup();
		throwables = new FlxGroup();
		rocks = new FlxGroup();
		scores = new Array();
		
		add(new FlxSprite(0, 0, "img/ground.png"));
		playersAvatars = new Array();
	
		
		
		var counter:Int = 0;
		var positions:Array<Point> = new Array();
		positions.push(new Point(100, 100)); 
		positions.push(new Point(1280 - 200, 720 - 200));
		positions.push(new Point(1280 - 200, 100));
		positions.push(new Point(100, 720 - 200)); 
		for (gamepadId in joystickId) 
		{
			
			createPlayer(positions[counter].x, positions[counter].y, new Joystick(FlxG.gamepads.getByID(gamepadId)), counter);
			++counter;
		}
		explosions = new FlxGroup();
		for (i in 0...(joystickId.length+2)) 
		{
			createRock();
		}
		add(explosions);


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
		
		var top = new FlxSprite( 10, -10);
		top.width = 1280+20;
		top.height = 100;
		top.immovable = true;
		walls.add(top);
		
		var down = new FlxSprite( -10, 720);
		down.width = 1280+20;
		down.height = 10;
		down.immovable = true;
		walls.add(down);
		
		add(new FlxSprite(0, 0, "img/frontGround.png"));
		playersAvatars.push(new FlxSprite(295 * 0 + 80, 30, "img/GnoAvatar_Blue.png"		) );
		playersAvatars.push(new FlxSprite(295 * 1 + 80, 30, "img/GnoAvatar_Red.png"			) );
		playersAvatars.push(new FlxSprite(295 * 2 + 80, 30, "img/GnoAvatar_Yellow.png"		) );
		playersAvatars.push(new FlxSprite(295 * 3 + 80, 30, "img/GnoAvatar_Green.png"		) );
		for (i in 0...(joystickId.length)) 
		{
			var text = new FlxText(100 + (1180 / 4) * i + 60, 50, 100, "0", 20);
			scores.push(text);
			add(text);
			
			add( playersAvatars[i] );
			
		}
	}
	
	function createRock() 
	{
		var rock:Mushroom = new Mushroom(100+Math.random()*1000,100+Math.random()*500,explosions);
		rocks.add(rock);
		throwables.add(rock);
		add(rock);
	}
	function createPlayer(aX:Float, aY:Float, controller:PlayerInput,aId:Int)
	{
		var colorTrans:String ="red";
		if (aId == 0)
		{
			colorTrans = "blue";
		}
		if (aId == 1)
		{
			colorTrans = "red";
		}
		if (aId == 2)
		{
			colorTrans = "yellow";
		}
		if (aId == 3)
		{
			colorTrans = "green";
		}
		player = new Player(controller,colorTrans,aX, aY);
		player.ID=aId;
		add(player);
		players.add(player);
	}
	var winState:Bool;
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		FlxG.collide(players, head, playerVsHead);
		FlxG.collide(players, rocks, playerVsRocks);
		FlxG.collide(walls, players);
		FlxG.collide(walls, throwables, throwableVsWall);
		if (winState)
		{
			if (FlxG.gamepads.anyJustPressed(FlxGamepadInputID.BACK)) FlxG.switchState(new Start());
			if (FlxG.gamepads.anyJustPressed(FlxGamepadInputID.START)) FlxG.switchState(new GameState(joystickId));
		}
		if (head.player != null)
		{
			head.player.incrementScore(elapsed);
			scores[head.player.ID].text = Std.int((head.player.score/2500)*100)+"%";
			if (head.player.score >= 2500)
			{
				
				skeleton = new Skeleton(head.player.x, head.player.y);
				add(skeleton);
				
				FlxG.sound.music.stop();
				FlxG.sound.play("img/Victory.mp3");
				switch head.player.ID
				{
					case 0:
						add(new FlxSprite(0, 0, "img/win title blue.png"));
					case 1: 
						add(new FlxSprite(0, 0, "img/win title red.png"));
					case 2: 
						add(new FlxSprite(0, 0, "img/win title yellow.png"));
					case 3: 
						add(new FlxSprite(0, 0, "img/win title green.png"));
					default:
				}
				winState = true;
				head.player.kill();
				head.kill();
				head.player = null;
			}
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