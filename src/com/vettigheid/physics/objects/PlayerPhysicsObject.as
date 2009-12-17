package com.vettigheid.physics.objects
{
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Collision.b2ContactPoint;
	
	import com.vettigheid.engine.command.KeyboardCommand;
	import com.vettigheid.physics.component.DynamicPhysicsComponent;
	
	import flash.geom.Point;
	
	public class PlayerPhysicsObject extends DynamicPhysicsComponent
	{
		private var _grounded:Boolean = false;
		private var _jumping:Boolean = false;
		
		public function PlayerPhysicsObject()
		{
			super();
		}
		
		public function build(position:Point):void
		{
			var radius:Number = 35;
			
			// Create a circle shape correspondening to the size of the player
			this.shape = this.createCircle(radius, 1, 1, .1);
			
			// The massData makes sure that the player has a fixed rotation
			var massData:b2MassData = new b2MassData();
			massData.mass = 1;
			this.mass = massData;

			// Set the player to its position in the level
			this.position = new Point(position.x + (radius / 2), position.y + (radius / 2));
			
			// Set the players movement speed
			this.speed = new Point(3, 7);
			
			// Not quite sure what this does
			this.body.m_linearDamping = 1;
		}
		
		public function collisionEnemyAddHandler(point:b2ContactPoint=null):void
		{
			this._respawn = true;
		}
		
		public function collisionFloorAddHandler(point:b2ContactPoint=null):void
		{
			if(point.normal.y >= -1 && point.normal.y < 0)
			{
				_grounded = true;
			}
		}
		
		public function collisionFloorPersistHandler(point:b2ContactPoint=null):void
		{
			if(point.normal.y >= -1 && point.normal.y < 0)
			{
				_grounded = true;
			}
		}
		
		public function collisionFloorRemoveHandler(point:b2ContactPoint=null):void
		{
			if(point.normal.y >= -1 && point.normal.y < 0)
			{
				_grounded = false;
			}
		}
		
		public function move(directions:Array):void
		{
			body.WakeUp();
			
			if(directions[KeyboardCommand.LEFT] && _grounded)
			{
				this.setLinearVelocity(-speed.x, body.GetLinearVelocity().y);
			}
			
			if(directions[KeyboardCommand.RIGHT] && _grounded)
			{
				this.setLinearVelocity(speed.x, body.GetLinearVelocity().y);
			}
			
			if(directions[KeyboardCommand.UP] && _grounded && !_jumping)
			{
				this.setLinearVelocity(body.GetLinearVelocity().x, -speed.y);
				_jumping = true;
			}
			
			if(!directions[KeyboardCommand.UP] && _grounded)
			{
				_jumping = false;
			}
		}
		
		override public function respawn():void
		{
			_grounded = false;
			super.respawn();
		}
	}
}