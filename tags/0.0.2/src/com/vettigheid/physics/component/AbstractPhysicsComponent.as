package com.vettigheid.physics.component
{
	import Box2D.Collision.Shapes.b2CircleDef;
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Collision.Shapes.b2ShapeDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	
	import com.vettigheid.engine.model.ModelLocator;
	import com.vettigheid.engine.vo.AbstractValueObject;
	
	import flash.geom.Point;
	
	public class AbstractPhysicsComponent
	{
		protected var model:ModelLocator;
		
		private var _body:b2Body;
		private var _bodydef:b2BodyDef;
		private var _mass:b2MassData;
		private var _position:Point;
		private var _shape:b2ShapeDef;
		private var _vo:AbstractValueObject;
		
		public function AbstractPhysicsComponent()
		{
			model = ModelLocator.getInstance();
			
			_bodydef = new b2BodyDef();	
		}
		
		public function get body():b2Body
		{
			return _body;
		}
		
		public function set body(value:b2Body):void
		{
			_body = value;
		}
		
		public function get bodydef():b2BodyDef
		{
			return _bodydef;
		}
		
		public function set mass(value:b2MassData):void
		{
			_mass = value;
			_body.SetMass(_mass);
		}

		public function get position():Point
		{
			return _position;
		}

		public function set position(value:Point):void
		{
			_position = value;
			
			_body.SetLinearVelocity(new b2Vec2(0, 0));
			_body.SetXForm(new b2Vec2(value.x / 30, value.y / 30), 0);
		}
		
		public function get shape():b2ShapeDef
		{
			return _shape;			
		}
		
		public function set shape(value:b2ShapeDef):void
		{
			_shape = value;
			
			_body.CreateShape(_shape);
			_body.SetMassFromShapes();
		}
		
		protected function createBox(width:Number, height:Number, x:Number, y:Number, density:Number, friction:Number, restitution:Number, oriented:Boolean=false):b2ShapeDef
		{
			var box:b2PolygonDef = new b2PolygonDef();
			
			if(oriented)
			{
				box.SetAsOrientedBox(width / 30 / 2, height / 30 / 2, new b2Vec2(x / 30, y / 30), 0);
			}
			else
			{
				box.SetAsBox(width / 30 / 2, height / 30 / 2);
			}
			
			box.density = density;
			box.friction = friction;
			box.restitution = restitution;
			
			return box;
		}
		
		protected function createCircle(radius:Number, density:Number, friction:Number, restitution:Number):b2CircleDef
		{
			// Make a new b2ShapeDef in the shape of a circle
			var circle:b2CircleDef = new b2CircleDef();
			
			// Set some common circle parameters
			circle.radius = radius / 2 / 30;
			circle.density = density;
			circle.friction = friction;
			circle.restitution = restitution;
			
			// Return the new b2CircleDef
			return circle;
		}
	}
}