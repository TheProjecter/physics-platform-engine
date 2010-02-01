package com.vettigheid.physics.objects
{
	import Box2D.Collision.b2ContactPoint;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.b2FixtureDef;
	
	import com.vettigheid.engine.event.ItemEvent;
	import com.vettigheid.engine.vo.AbstractValueObject;
	import com.vettigheid.physics.component.SensorPhysicsComponent;
	
	import flash.geom.Point;
	
	public class ItemPhysicsObject extends SensorPhysicsComponent
	{
		public function ItemPhysicsObject(name:String)
		{			
			super(name);
		}
		
		override public function build(vo:AbstractValueObject):void
		{
			var radius:Number = 20;

			// Create a circle shape correspondening to the size of the item
			var sensor:b2FixtureDef = this.createCircle(radius, 0, 1, .1);	
			
			// Make the shape a sensor so it do not collides
			sensor.isSensor = true;
			this.shape = sensor;
			
			// Set the item to its position in the level
			this.position = new Point(vo.position.x + (radius / 2) + (this.model.tileSize / 4), vo.position.y + (radius / 2) + (this.model.tileSize / 4));
		}
		
		public function collisionPlayerHandler(point:b2ContactPoint=null, contact:b2Contact=null, angle:Number=undefined):void
		{
			var itemEvent:ItemEvent = new ItemEvent(ItemEvent.ITEM_HIT, this.name);
			itemEvent.dispatch();
		}
	}
}