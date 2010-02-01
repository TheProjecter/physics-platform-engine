package com.vettigheid.physics.objects
{
	import Box2D.Collision.b2ContactPoint;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import com.vettigheid.engine.vo.AbstractValueObject;
	import com.vettigheid.physics.component.AbstractPhysicsComponent;
	
	import flash.geom.Point;

	public class CloudPhysicsObject extends AbstractPhysicsComponent
	{
		public function CloudPhysicsObject(name:String)
		{
			super(name);
		}
		
		override public function build(vo:AbstractValueObject):void
		{
			this.shape = this.createBox(model.tileSize, model.tileSize, 0, 0, 0, .5, .2);
			this.position = new Point(vo.position.x + (this.model.tileSize / 2), vo.position.y + (this.model.tileSize / 2));
		}
		
		public function collisionPlayerAddAndPersistHandler(point:b2ContactPoint=null, contact:b2Contact=null, angle:Number=undefined):void
		{
			if(angle > -140 && angle < 140)
			{
				// contact.m_flags |= b2Contact.e_nonSolidFlag;
			}
			
			if(point.normal.y >= -1 && point.normal.y < 0)
			{
				PlayerPhysicsObject(model.physics.getObject("Player")).grounded = true;
			}
		}

		public function collisionPlayerRemoveHandler(point:b2ContactPoint=null, contact:b2Contact=null, angle:Number=undefined):void
		{
			/*if (contact.m_manifoldCount == 0 )
			{
            	// contact.m_flags &= ~b2Contact.e_nonSolidFlag;
         	}*/
         	
         	if(point.normal.y >= -1 && point.normal.y < 0)
			{
				PlayerPhysicsObject(model.physics.getObject("Player")).grounded = false;
			}
		}
	}
}