package com.vettigheid.physics.collision
{
	import Box2D.Collision.b2ContactPoint;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.Contacts.b2ContactResult;
	import Box2D.Dynamics.b2ContactListener;

	public class PhysicsCollisionListener extends b2ContactListener
	{
		private var _collisions:Array = new Array();
		
		override public virtual function Add(point:b2ContactPoint, contact:b2Contact):void
		{
			for each(var collision:PhysicsCollision in _collisions)
			{
				if(collision.type == PhysicsCollision.ADD && checkCollision(collision, point))
				{
					collision.onCollision(point, contact);
				}
			}
		}
		
		override public virtual function Persist(point:b2ContactPoint, contact:b2Contact):void
		{
			for each(var collision:PhysicsCollision in _collisions)
			{
				if(collision.type == PhysicsCollision.PERSIST && checkCollision(collision, point))
				{
					collision.onCollision(point, contact);
				}
			}
		}
		
		override public virtual function Remove(point:b2ContactPoint, contact:b2Contact):void
		{
			for each(var collision:PhysicsCollision in _collisions)
			{
				if(collision.type == PhysicsCollision.REMOVE && checkCollision(collision, point))
				{
					collision.onCollision(point, contact);
				}
			}	
		}
		
		override public virtual function Result(point:b2ContactResult, contact:b2Contact):void
		{

		}
		
		public function addCollision(collision:PhysicsCollision):void
		{
			_collisions.push(collision);
		}
		
		private function checkAngle(point:b2ContactPoint, reverse:Number, solidityAng:Number=90, solidityRange:Number=60):Number
		{
			var isColliding:Boolean = false;
			
			// if the contactPoint's normal is not within a 60 degree range from "down", disable collisions
			var normalAng:Number = Math.atan2( point.normal.y * reverse, point.normal.x * reverse );
         	var deltaAng:Number = (normalAng - (solidityAng * Math.PI / 180.0))
         
         	// normalize angle
         	deltaAng %= (Math.PI * 2)
         	if (deltaAng < -Math.PI) { deltaAng += Math.PI * 2; }
         	if (deltaAng > Math.PI) { deltaAng -= Math.PI * 2; }
         
         	var check:Boolean = (Math.abs(deltaAng) < (solidityRange * Math.PI / 180.0));
			
			return deltaAng * 180 / Math.PI;
		}
		
		private function checkCollision(collision:PhysicsCollision, point:b2ContactPoint):Boolean
		{
			var isColliding:Boolean = false;
			
			if(collision.component1.body == point.shape1.GetBody() || collision.component1.body == point.shape2.GetBody())
			{
				if(collision.component2.body == point.shape1.GetBody() || collision.component2.body == point.shape2.GetBody())
				{
					isColliding = true;
					collision.angle = checkAngle(point, 1);
				}
			}
			
			return isColliding;
		}
	}
}