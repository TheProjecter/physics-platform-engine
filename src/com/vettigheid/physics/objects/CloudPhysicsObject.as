package com.vettigheid.physics.objects
{
	import Box2D.Collision.b2ContactPoint;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import com.vettigheid.engine.vo.CloudValueObject;
	import com.vettigheid.physics.component.AbstractPhysicsComponent;
	
	import flash.geom.Point;

	public class CloudPhysicsObject extends AbstractPhysicsComponent
	{
		public function CloudPhysicsObject()
		{
			super();
		}
		
		public function build(vo:CloudValueObject):void
		{
			this.shape = this.createBox(model.tileSize, model.tileSize, 0, 0, 0, .5, .2);
			this.position = new Point(vo.position.x + (this.model.tileSize / 2), vo.position.y + (this.model.tileSize / 2));
		}
		
		public function collisionPlayerAddAndPersistHandler(point:b2ContactPoint=null, contact:b2Contact=null):void
		{
			if(point.shape1 == this.body.GetShapeList())
			{
				collisionHandler(point, contact, -1);
			}
			else
			{
				collisionHandler(point, contact, 1);
			}
		}

		public function collisionPlayerRemoveHandler(point:b2ContactPoint=null, contact:b2Contact=null):void
		{
			if (contact.m_manifoldCount == 0 )
			{
            	contact.m_flags &= ~b2Contact.e_nonSolidFlag;
         	}
		}
		
		private function collisionHandler(point:b2ContactPoint, contact:b2Contact, reverse:Number, solidityAng:Number=90, solidityRange:Number=60):void
		{
			// if the contactPoint's normal is not within a 60 degree range from "down", disable collisions
			var normalAng:Number = Math.atan2( point.normal.y * reverse, point.normal.x * reverse );
         	var deltaAng:Number = (normalAng - (solidityAng*Math.PI/180.0))
         
         	// normalize angle
         	deltaAng %= (Math.PI * 2)
         	if (deltaAng < -Math.PI) { deltaAng += Math.PI * 2; }
         	if (deltaAng > Math.PI) { deltaAng -= Math.PI * 2; }
         
         	var platformIsBelowCreature:Boolean = ( Math.abs(deltaAng) < (solidityRange * Math.PI / 180.0) );

         	if (!platformIsBelowCreature)
         	{
         	   // disable collisions between this shape pair while they remain in contact
         	   contact.m_flags |= b2Contact.e_nonSolidFlag;
         	}
		}
	}
}