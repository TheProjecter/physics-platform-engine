package com.vettigheid.physics.component
{
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Collision.b2ContactPoint;
	
	import com.vettigheid.engine.command.KeyboardCommand;
	
	import flash.geom.Point;
	
	public class PlayerPhysicsComponent extends DynamicPhysicsComponent
	{
		private var _grounded:Boolean = false;
		private var _jumping:Boolean = false;
		
		public function PlayerPhysicsComponent()
		{
			super(0, 0);
		}
		
		public function build(position:Point):void
		{
			// Create a circle shape correspondening to the size of the player
			this.shape = this.createCircle(35, 1, 1, .1);
			
			// The massData makes sure that the player has a fixed rotation
			var massData:b2MassData = new b2MassData();
			massData.mass = 1;
			this.mass = massData;
			
			// Set the player to its position in the level
			this.position = position;
			
			// Not quite sure what this does
			this.body.m_linearDamping = 1;
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
			_grounded = false;
		}
		
		public function move(directions:Array):void
		{
			body.WakeUp();
			
			if(directions[KeyboardCommand.LEFT])
			{
				this.setLinearVelocity(-3, body.GetLinearVelocity().y);
			}
			
			if(directions[KeyboardCommand.RIGHT])
			{
				this.setLinearVelocity(3, body.GetLinearVelocity().y);
			}
			
			if(directions[KeyboardCommand.UP] && !_jumping)
			{
				this.setLinearVelocity(body.GetLinearVelocity().x, -7);
				_jumping = true;
			}
			
			if(!directions[KeyboardCommand.UP] && _grounded)
			{
				_jumping = false;
			}
		}
	}
}