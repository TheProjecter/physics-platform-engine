package com.vettigheid.physics.objects
{
	import Box2D.Collision.Shapes.b2ShapeDef;
	import Box2D.Collision.b2ContactPoint;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import com.vettigheid.engine.event.TrapEvent;
	import com.vettigheid.engine.vo.TrapValueObject;
	import com.vettigheid.physics.component.SensorPhysicsComponent;
	
	import flash.geom.Point;

	public class TrapPhysicsObject extends SensorPhysicsComponent
	{
		public function TrapPhysicsObject()
		{
			super();
		}
		
		public function build(vo:TrapValueObject):void
		{
			var sensor:b2ShapeDef = this.createBox(model.tileSize, model.tileSize / 4, 0, 0, 0, 1, .1); 	
			
			// Make the shape a sensor so it do not collides
			sensor.isSensor = true;
			
			this.shape = sensor;

			// Set the item to its position in the level
			this.position = new Point(vo.position.x + model.tileSize / 2, vo.position.y + (model.tileSize - (model.tileSize / 4) / 2));
		}
		
		public function collisionPlayerHandler(point:b2ContactPoint=null, contact:b2Contact=null):void
		{
			this.isHit = true;
			
			var trapEvent:TrapEvent = new TrapEvent(TrapEvent.TRAP_HIT);
			trapEvent.dispatch();
		}
	}
}