package com.vettigheid.physics.component
{
	import Box2D.Common.Math.b2Vec2;
	
	public class DynamicPhysicsComponent extends AbstractPhysicsComponent
	{
		public function DynamicPhysicsComponent(x:Number, y:Number)
		{
			super(x, y);
		}
		
		
		protected function setLinearVelocity(x:Number, y:Number):void
		{
			this.body.SetLinearVelocity(new b2Vec2(x, y));
		}
	}
}