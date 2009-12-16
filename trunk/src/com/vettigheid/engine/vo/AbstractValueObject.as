package com.vettigheid.engine.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import com.vettigheid.physics.component.AbstractPhysicsComponent;
	
	import flash.geom.Point;

	public class AbstractValueObject implements IValueObject
	{
		private var _physics:AbstractPhysicsComponent;
		private var _position:Point;
		
		public function AbstractValueObject(position:Point)
		{
			_position = position;
		}
		
		public function get physics():AbstractPhysicsComponent
		{
			return _physics;
		}
		
		public function set physics(value:AbstractPhysicsComponent):void
		{
			_physics = value;
			_physics.vo = this;
		}
		
		public function get position():Point
		{
			return _position;
		}
	}
}