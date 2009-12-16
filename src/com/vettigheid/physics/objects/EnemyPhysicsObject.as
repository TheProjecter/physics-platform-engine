package com.vettigheid.physics.objects
{
	import Box2D.Collision.Shapes.b2MassData;
	
	import com.vettigheid.physics.component.DynamicPhysicsComponent;
	
	import flash.geom.Point;

	public class EnemyPhysicsObject extends DynamicPhysicsComponent
	{
		private var _minimal:Point;
		private var _maximal:Point;
		
		public function EnemyPhysicsObject()
		{
			super(0, 0, new Point(3, 0));
		}
		
		public function build(position:Point, minimal:Point, maximal:Point):void
		{
			_minimal = minimal;
			_maximal = maximal;
			
			// Create a circle shape correspondening to the size of the enemy
			this.shape = this.createCircle(35, 1, 1, .1);
			
			// The massData makes sure that the enemy has a fixed rotation
			var massData:b2MassData = new b2MassData();
			massData.mass = 1;
			this.mass = massData;
			
			// Set the enemy to its position in the level
			this.position = position;
			
			// Not quite sure what this does
			this.body.m_linearDamping = 1;
		}
		
		public function move():void
		{
			body.WakeUp();
			
			if(body.GetPosition().x * 30 >= _maximal.x || body.GetPosition().x * 30 <= _minimal.x)
			{
				speed.x = -speed.x;
			}

			this.setLinearVelocity(speed.x, body.GetLinearVelocity().y);
		}
	}
}