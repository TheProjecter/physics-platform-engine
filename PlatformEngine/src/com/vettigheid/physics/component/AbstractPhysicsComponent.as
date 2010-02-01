package com.vettigheid.physics.component
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	
	import com.vettigheid.engine.model.ModelLocator;
	import com.vettigheid.engine.vo.AbstractValueObject;
	
	import flash.geom.Point;
	
	public class AbstractPhysicsComponent
	{
		protected var model:ModelLocator;
		
		private var _action:String;
		private var _body:b2Body;
		private var _bodydef:b2BodyDef;
		private var _direction:String;
		private var _mass:b2MassData;
		private var _name:String;
		private var _position:Point;
		private var _shape:b2FixtureDef;
		private var _vo:AbstractValueObject;
		
		public function AbstractPhysicsComponent(name:String)
		{
			model = ModelLocator.getInstance();
			
			_bodydef = new b2BodyDef();	
			_direction = "right";
			_name = name;
		}
		
		public function get action():String
		{
			return _action;
		}
		
		public function set action(value:String):void
		{
			_action = value;
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
		
		public function get direction():String
		{
			return _direction;
		}
		
		public function set direction(value:String):void
		{
			_direction = value;
		}
		
		public function set mass(value:b2MassData):void
		{
			_mass = value;
			_body.SetMassData(_mass);
		}

		public function get name():String
		{
			return _name;
		}

		public function get position():Point
		{
			return _position;
		}

		public function set position(value:Point):void
		{
			_position = value;
			
			_body.SetLinearVelocity(new b2Vec2(0, 0));
			_body.SetPosition(new b2Vec2(value.x / 30, value.y / 30));
		}
		
		public function get shape():b2FixtureDef
		{
			return _shape;			
		}
		
		public function set shape(value:b2FixtureDef):void
		{
			_shape = value;

			_body.CreateFixture(value);
		}
		
		public function build(vo:AbstractValueObject):void
		{
			
		}
		
		protected function createBox(width:Number, height:Number, x:Number, y:Number, density:Number, friction:Number, restitution:Number, oriented:Boolean=false):b2FixtureDef
		{
			var box:b2FixtureDef = new b2FixtureDef();
			var boxDef:b2PolygonShape = new b2PolygonShape();
			
			if(oriented)
			{
				boxDef.SetAsOrientedBox(width / 30 / 2, height / 30 / 2, new b2Vec2(x / 30, y / 30), 0);
			}
			else
			{
				boxDef.SetAsBox(width / 30 / 2, height / 30 / 2);
			}
			
			box.shape = boxDef;
			box.density = density;
			box.friction = friction;
			box.restitution = restitution;
			
			return box;
		}
		
		protected function addFixture(fixture:b2FixtureDef):void
		{
			this.body.CreateFixture(fixture);
		}
		
		protected function createCircle(radius:Number, density:Number, friction:Number, restitution:Number):b2FixtureDef
		{
			// Make a new b2ShapeDef in the shape of a circle
			var circle:b2FixtureDef = new b2FixtureDef();
			circle.shape = new b2CircleShape(radius / 2 / 30);
			
			// Set some common circle parameters
			circle.density = density;
			circle.friction = friction;
			circle.restitution = restitution;
			
			// Return the new b2CircleDef
			return circle;
		}
		
		protected function createPoly(points:Array, x:Number, y:Number, density:Number, friction:Number, restitution:Number):b2FixtureDef
		{
			var poly:b2FixtureDef = new b2FixtureDef();
			
			var _points:Array = new Array();
			for(var i:int = 0; i < points.length; i++)
			{
				_points.push((x + points[i].x) / 30, (y + points[i].y) / 30);
			}
			
			var shape:b2PolygonShape = new b2PolygonShape();
			shape.SetAsArray(_points, _points.length);
			
			poly.density = density;
			poly.friction = friction;
			poly.restitution = restitution;
			
			return poly;
		}
	}
}