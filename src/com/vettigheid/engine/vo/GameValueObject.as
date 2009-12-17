package com.vettigheid.engine.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	public class GameValueObject implements IValueObject
	{
		private var _enemies:Array;
		private var _items:Array;
		private var _level:LevelValueObject;
		private var _player:PlayerValueObject;
		private var _ready:Boolean = false;
		
		public function GameValueObject(level:LevelValueObject, player:PlayerValueObject, enemies:Array, items:Array)
		{
			_enemies = enemies;
			_items = items;
			_level = level;
			_player = player;
		}
		
		public function get enemies():Array
		{
			return _enemies;
		}
		
		public function get items():Array
		{
			return _items;
		}
		
		public function get level():LevelValueObject
		{
			return _level;
		}
		
		public function get player():PlayerValueObject
		{
			return _player;
		}
		
		public function get ready():Boolean
		{
			return _ready;
		}
		
		public function set ready(value:Boolean):void
		{
			_ready = value;
		}
	}
}