package com.vettigheid.physics.objects
{
	import Box2D.Collision.Shapes.b2ShapeDef;
	import Box2D.Collision.b2ContactPoint;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import com.vettigheid.engine.event.ExitEvent;
	import com.vettigheid.engine.vo.AbstractValueObject;
	import com.vettigheid.physics.component.SensorPhysicsComponent;
	
	import flash.geom.Point;

	public class ExitPhysicsObject extends SensorPhysicsComponent
	{
		public function ExitPhysicsObject(name:String)
		{
			super(name);
		}
		
		override public function build(vo:AbstractValueObject):void
		{
			var sensor:b2ShapeDef = this.createBox(model.tileSize - 10, model.tileSize, 0, 0, 0, .5, .2);
			
			// Make the shape a sensor so it do not collides
			sensor.isSensor = true;
			this.shape = sensor;
			
			this.position = new Point(vo.position.x + (this.model.tileSize / 2), vo.position.y + (this.model.tileSize / 2));
		}
		
		public function collisionPlayerHandler(point:b2ContactPoint=null, contact:b2Contact=null, angle:Number=undefined):void
		{
			var exitEvent:ExitEvent = new ExitEvent(ExitEvent.EXIT_HIT);
			exitEvent.dispatch();
		}
	}
}