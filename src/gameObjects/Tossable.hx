package gameObjects;
import flixel.FlxSprite;

/**
 * @author Joaquin
 */
interface Tossable 
{
	var facing(default, set):Int;
	function toss(x:Float,y:Float):Void;
	function grab(player:Player):Bool;
	function bounce():Void;
	function drop():Void;
}