package io;

/**
 * @author Joaquin
 */
interface PlayerInput 
{
	function left():Bool;
	function right():Bool;
	function up():Bool;
	function down():Bool;
	
	function tossX():Float;
	function tossY():Float;
	function toss():Bool;
}