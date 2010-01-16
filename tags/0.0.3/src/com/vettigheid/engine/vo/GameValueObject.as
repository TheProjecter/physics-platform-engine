package com.vettigheid.engine.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	import flash.utils.Dictionary;

	public class GameValueObject implements IValueObject
	{
		private var _objects:Dictionary;
		private var _ready:Boolean = false;
		
		public function GameValueObject(level:LevelValueObject, player:PlayerValueObject, clouds:Array=null, elevators:Array=null, enemies:Array=null, exit:ExitValueObject=null, items:Array=null, traps:Array=null)
		{
			_objects = new Dictionary(true);
			
			_objects["clouds"] = clouds;
			_objects["elevators"] = elevators;
			_objects["exit"] = exit;
			_objects["enemies"] = enemies;
			_objects["items"] = items;
			_objects["level"] = level;
			_objects["player"] = player;
			_objects["traps"] = traps;
		}
		
		public function get clouds():Array
		{
			return _objects["clouds"];
		}
		
		public function get elevators():Array
		{
			return _objects["elevators"];
		}
		
		public function get enemies():Array
		{
			return _objects["enemies"];
		}
		
		public function get exit():ExitValueObject
		{
			return _objects["exit"];
		}
		
		public function get items():Array
		{
			return _objects["items"];
		}
		
		public function get level():LevelValueObject
		{
			return _objects["level"];
		}
		
		public function get player():PlayerValueObject
		{
			return _objects["player"];
		}
		
		public function get ready():Boolean
		{
			return _ready;
		}
		
		public function set ready(value:Boolean):void
		{
			_ready = value;
		}
		
		public function get traps():Array
		{
			return _objects["traps"];
		}
	}
}