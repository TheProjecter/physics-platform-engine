package com.vettigheid.engine.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	import flash.geom.Point;

	public class EnemyValueObject extends AbstractValueObject implements IValueObject
	{
		private var _maximal:Point;
		private var _minimal:Point;
		
		public function EnemyValueObject(name:String, position:Point, minimal:Point, maximal:Point)
		{
			super(name, position);
			
			_maximal = maximal;
			_minimal = minimal;
		}
	
		public function get maximal():Point
		{
			return _maximal;	
		}	
		
		public function get minimal():Point
		{
			return _minimal;
		}
	}
}