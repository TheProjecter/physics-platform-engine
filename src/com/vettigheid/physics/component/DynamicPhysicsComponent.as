package com.vettigheid.physics.component
{
	import Box2D.Common.Math.b2Vec2;
	
	import flash.geom.Point;
	
	public class DynamicPhysicsComponent extends AbstractPhysicsComponent
	{
		public var _respawn:Boolean = false;
		
		private var _speed:Point;
		
		public function DynamicPhysicsComponent()
		{
			super();
		}
				
		public function respawn():void
		{
			this.position = this.position;
			_respawn = false;
		}
		
		public function get speed():Point
		{
			return _speed;
		}
		
		public function set speed(value:Point):void
		{
			_speed = value;
		}
		
		public function move():void
		{
			
		}
			
		protected function setLinearVelocity(x:Number, y:Number):void
		{
			this.body.SetLinearVelocity(new b2Vec2(x, y));
		}
	}
}