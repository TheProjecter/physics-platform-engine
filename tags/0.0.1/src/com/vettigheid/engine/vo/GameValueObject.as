package com.vettigheid.engine.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	public class GameValueObject implements IValueObject
	{
		private var _level:LevelValueObject;
		private var _player:PlayerValueObject;
		private var _ready:Boolean = false;
		
		public function GameValueObject(level:LevelValueObject, player:PlayerValueObject)
		{
			_level = level;
			_player = player;
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