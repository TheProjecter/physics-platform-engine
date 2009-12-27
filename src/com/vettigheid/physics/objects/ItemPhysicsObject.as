package com.vettigheid.physics.objects
{
	import Box2D.Collision.Shapes.b2ShapeDef;
	import Box2D.Collision.b2ContactPoint;
	
	import com.vettigheid.physics.component.SensorPhysicsComponent;
	
	import flash.geom.Point;
	
	public class ItemPhysicsObject extends SensorPhysicsComponent
	{
		private var _name:String;
		
		public function ItemPhysicsObject(name:String)
		{
			_name = name;
			
			super();
		}
		
		public function build(position:Point):void
		{
			var radius:Number = 20;

			// Create a circle shape correspondening to the size of the item
			var sensor:b2ShapeDef = this.createCircle(radius, 0, 1, .1);	
			
			// Make the shape a sensor so it do not collides
			sensor.isSensor = true;
			
			this.shape = sensor;
			
			// Set the item to its position in the level
			this.position = new Point(position.x + (radius / 2) + (this.model.tileSize / 4), position.y + (radius / 2) + (this.model.tileSize / 4));
		}
		
		public function collisionPlayerHandler(point:b2ContactPoint=null):void
		{
			this.isHit = true;
		}
	}
}