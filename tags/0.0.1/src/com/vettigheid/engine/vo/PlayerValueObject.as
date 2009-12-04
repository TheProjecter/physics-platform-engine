package com.vettigheid.engine.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	import flash.geom.Point;

	public class PlayerValueObject implements IValueObject
	{
		private var _position:Point;
		
		public function PlayerValueObject(position:Point)
		{
			_position = position;
		}
		
		public function get position():Point
		{
			return _position;
		}
	}
}