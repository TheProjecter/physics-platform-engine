package com.vettigheid.physics.component
{
	public class SensorPhysicsComponent extends AbstractPhysicsComponent
	{
		private var _isHit:Boolean = false;
		
		public function SensorPhysicsComponent(name:String)
		{
			super(name);
		}
	}
}