package com.vettigheid.engine.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	import flash.geom.Point;

	public class EnemyValueObject implements IValueObject
	{
		private var _maximal:Point;
		private var _minimal:Point;
		private var _position:Point;
		
		public function EnemyValueObject(position:Point, minimal:Point, maximal:Point)
		{
			_maximal = maximal;
			_minimal = minimal;
			_position = position;
		}
	
		public function get maximal():Point
		{
			return _maximal;	
		}	
		
		public function get minimal():Point
		{
			return _minimal;
		}
		
		public function get position():Point
		{
			return _position;
		}
	}
}