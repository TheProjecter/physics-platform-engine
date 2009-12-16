package com.vettigheid.physics.component
{
	import Box2D.Common.Math.b2Vec2;
	
	import flash.geom.Point;
	
	public class DynamicPhysicsComponent extends AbstractPhysicsComponent
	{
		private var _speed:Point;
		
		public function DynamicPhysicsComponent(x:Number, y:Number, speed:Point)
		{
			super(x, y);
		
			_speed = speed;
		}
		
		public function get speed():Point
		{
			return _speed;
		}
				
		public function respawn():void
		{
			this.position = new Point(10, 10);
		}		
				
		protected function setLinearVelocity(x:Number, y:Number):void
		{
			this.body.SetLinearVelocity(new b2Vec2(x, y));
		}
	}
}