package com.vettigheid.physics.objects
{
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Collision.b2ContactPoint;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import com.vettigheid.physics.component.DynamicPhysicsComponent;
	
	import flash.geom.Point;

	public class EnemyPhysicsObject extends DynamicPhysicsComponent
	{
		private var _minimal:Point;
		private var _maximal:Point;
		
		public function EnemyPhysicsObject(name:String)
		{
			super(name);
		}
		
		public function build(position:Point, minimal:Point, maximal:Point):void
		{
			var radius:Number = 35;
			
			_minimal = new Point(minimal.x + (radius / 2), minimal.y + (radius / 2));
			_maximal = new Point(maximal.x + (radius / 2), maximal.y + (radius / 2));
			
			// Create a circle shape correspondening to the size of the enemy
			this.shape = this.createCircle(radius, 1, 1, .1);
			
			// The massData makes sure that the enemy has a fixed rotation
			var massData:b2MassData = new b2MassData();
			massData.mass = 1;
			this.mass = massData;
			
			// Set the enemy to its position in the level
			this.position = new Point(position.x + (radius / 2), position.y + (radius / 2));
			
			// Set the enemy's movement speed
			this.speed = new Point(2, 7);
			
			// Not quite sure what this does
			this.body.m_linearDamping = 1;
		}
		
		public function collisionPlayerAddHandler(point:b2ContactPoint=null, contact:b2Contact=null, angle:Number=undefined):void
		{
			if(angle > -30 && angle < 30)
			{
				model.physics.destroyObject(model.physics.getObject(this.name));
			}
			else
			{
				PlayerPhysicsObject(model.physics.getObject("Player"))._respawn = true;
			}
		}
		
		override public function move():void
		{
			//TODO: Make sure that the enemy change direction when touching a wall
			body.WakeUp();
			
			if(body.GetPosition().x * 30 >= _maximal.x || body.GetPosition().x * 30 <= _minimal.x)
			{
				speed.x = -speed.x;
			}

			this.setLinearVelocity(speed.x, body.GetLinearVelocity().y);
			
			super.move();
		}
	}
}