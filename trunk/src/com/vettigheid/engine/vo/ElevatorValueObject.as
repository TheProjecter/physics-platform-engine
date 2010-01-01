package com.vettigheid.engine.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	import flash.geom.Point;

	public class ElevatorValueObject extends AbstractValueObject implements IValueObject
	{
		private var _direction:String;
		private var _maximal:Number;
		private var _minimal:Number;
		
		public function ElevatorValueObject(name:String, position:Point, direction:String, minimal:Number, maximal:Number)
		{
			_direction = direction;
			_minimal = minimal;
			_maximal = maximal;
			
			super(name, position);
		}
		
		public function get direction():String
		{
			return _direction;
		}
		
		public function get maximal():Number
		{
			return _maximal;	
		}	
		
		public function get minimal():Number
		{
			return _minimal;
		}
	}
}