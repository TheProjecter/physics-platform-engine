package com.vettigheid.physics.collision
{
	import Box2D.Collision.b2ContactPoint;
	
	import com.vettigheid.physics.component.AbstractPhysicsComponent;
	
	public class PhysicsCollision
	{
		public static const ADD:String = "Call when collision is added";
		public static const PERSIST:String = "Call when collision persists";
		public static const REMOVE:String = "Call when collision is removed";
		public static const RESULT:String = "Call when collision results";
		
		private var _component1:AbstractPhysicsComponent;
		private var _component2:AbstractPhysicsComponent;
		private var _onCollision:Function;
		private var _type:String;
		
		public function PhysicsCollision(component1:AbstractPhysicsComponent, component2:AbstractPhysicsComponent, type:String, onCollision:Function)
		{
			_component1 = component1;
			_component2 = component2;
			_onCollision = onCollision;
			_type = type;
		}
		
		public function get component1():AbstractPhysicsComponent
		{
			return _component1;
		}
		
		public function get component2():AbstractPhysicsComponent
		{
			return _component2;
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function onCollision(point:b2ContactPoint):void
		{
			_onCollision(point);
		}
	}
}