package com.vettigheid.physics.component
{
	public class SensorPhysicsComponent extends AbstractPhysicsComponent
	{
		private var _isHit:Boolean = false;
		
		public function SensorPhysicsComponent(name:String)
		{
			super(name);
		}
		
		public function get isHit():Boolean
		{
			return _isHit;
		}
		
		public function set isHit(value:Boolean):void
		{
			_isHit = value;
		}
	}
}