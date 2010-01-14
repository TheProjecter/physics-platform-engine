package com.vettigheid.engine.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import com.vettigheid.physics.component.AbstractPhysicsComponent;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;

	public class AbstractValueObject implements IValueObject
	{
		private var _name:String;
		private var _physics:AbstractPhysicsComponent;
		private var _position:Point;
		
		public function AbstractValueObject(name:String, position:Point)
		{
			_name = name;
			_position = position;
		}

		public function get name():String
		{
			return _name;
		}
		
		public function get position():Point
		{
			return _position;
		}
	}
}