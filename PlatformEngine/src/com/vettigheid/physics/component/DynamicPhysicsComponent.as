package com.vettigheid.physics.component
{
	import Box2D.Common.Math.b2Vec2;
	
	import flash.geom.Point;
	
	public class DynamicPhysicsComponent extends AbstractPhysicsComponent
	{
		public var _respawn:Boolean = false;

		private var _speed:Point;
		
		public function DynamicPhysicsComponent(name:String)
		{
			super(name);
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
			if(this.body.GetLinearVelocity().x > 1)
			{
				this.direction = "right";
				this.action = "walk";
			}
			
			if(this.body.GetLinearVelocity().x < -1)
			{
				this.direction = "left";
				this.action = "walk";
			}
			
			if(this.body.GetLinearVelocity().y > 1)
			{
				this.action = "fall";
			}
			
			if(this.body.GetLinearVelocity().y < -1)
			{
				this.action = "jump";
			}
			
			if(this.body.GetLinearVelocity().x < 1 && this.body.GetLinearVelocity().x > -1 && this.body.GetLinearVelocity().y < 1 && this.body.GetLinearVelocity().y > -1)
			{
				this.action = "stand";
			}
		}
		
		public function respawn():void
		{
			this.position = this.position;
			_respawn = false;
		}
			
		protected function setLinearVelocity(x:Number, y:Number):void
		{
			this.body.SetLinearVelocity(new b2Vec2(x, y));
		}
	}
}