package com.vettigheid.physics.objects
{
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Collision.b2ContactPoint;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import com.vettigheid.engine.command.KeyboardCommand;
	import com.vettigheid.physics.component.DynamicPhysicsComponent;
	
	import flash.geom.Point;
	
	public class PlayerPhysicsObject extends DynamicPhysicsComponent
	{		
		private var _directions:Array;
		private var _grounded:Boolean = false;
		private var _jumping:Boolean = false;
		
		public function PlayerPhysicsObject(name:String)
		{
			_directions = new Array();
			
			super(name);
		}
		
		public function set directions(value:Array):void
		{
			_directions = value;
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
		
		public function collisionFloorAddHandler(point:b2ContactPoint=null, contact:b2Contact=null, angle:Number=undefined):void
		{
			if(point.normal.y >= -1 && point.normal.y < 0)
			{
				_grounded = true;
			}
		}
		
		public function collisionFloorPersistHandler(point:b2ContactPoint=null, contact:b2Contact=null, angle:Number=undefined):void
		{
			if(point.normal.y >= -1 && point.normal.y < 0)
			{
				_grounded = true;
			}
		}
		
		public function collisionFloorRemoveHandler(point:b2ContactPoint=null, contact:b2Contact=null, angle:Number=undefined):void
		{
			if(point.normal.y >= -1 && point.normal.y < 0)
			{
				_grounded = false;
			}
		}
		
		override public function move():void
		{
			body.WakeUp();
			
			if(_directions[KeyboardCommand.LEFT] && _grounded)
			{
				this.setLinearVelocity(-speed.x, body.GetLinearVelocity().y);
			}
			
			if(_directions[KeyboardCommand.RIGHT] && _grounded)
			{
				this.setLinearVelocity(speed.x, body.GetLinearVelocity().y);
			}
			
			if(_directions[KeyboardCommand.UP] && _grounded && !_jumping)
			{
				this.setLinearVelocity(body.GetLinearVelocity().x, -speed.y);
				_jumping = true;
			}
			
			if(!_directions[KeyboardCommand.UP] && _grounded)
			{
				_jumping = false;
			}

			if(this.body.GetLinearVelocity().x > 1 && _directions[KeyboardCommand.RIGHT])
			{
				this.direction = "right";
				this.action = "walk";
			}
			
			if(this.body.GetLinearVelocity().x < -1 && _directions[KeyboardCommand.LEFT])
			{
				this.direction = "left";
				this.action = "walk";
			}
			
			if(this.body.GetLinearVelocity().y > 1 && !_grounded)
			{
				this.action = "fall";
			}
			
			if(this.body.GetLinearVelocity().y < -1  && _directions[KeyboardCommand.UP])
			{
				this.action = "jump";
			}
			
			if(this.body.GetLinearVelocity().x < 1 && this.body.GetLinearVelocity().x > -1 && this.body.GetLinearVelocity().y < 1 && this.body.GetLinearVelocity().y > -1)
			{
				this.action = "stand";
			}
		}
		
		override public function respawn():void
		{
			_grounded = false;
			super.respawn();
		}
	}
}