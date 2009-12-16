package com.vettigheid.physics
{
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	
	import com.vettigheid.physics.collision.PhysicsCollision;
	import com.vettigheid.physics.collision.PhysicsCollisionListener;
	import com.vettigheid.physics.component.AbstractPhysicsComponent;
	
	import flash.display.Sprite;
	
	public class PhysicsWrapper
	{
		private var _collisionListener:PhysicsCollisionListener;
		private var _components:Array;
		private var _debugSprite:Sprite;
		private var _iterations:int = 10;
		private var _timeStep:Number = 1.0 / 30.0;
		private var _world:b2World;
		
		public function PhysicsWrapper(debug:Boolean=false)
		{
			init();
			if(debug) initDebug(); 
			
			_components = new Array();
		}
		
		public function get debugSprite():Sprite
		{
			return _debugSprite;
		}

		public function addCollision(collision:PhysicsCollision):void
		{
			_collisionListener.addCollision(collision);
		}

		public function addObject(name:String, component:AbstractPhysicsComponent):void
		{
			component.body = _world.CreateBody(component.bodydef);
			_components[name] = component;
		}
		
		public function getObject(name:String):AbstractPhysicsComponent
		{
			return _components[name];
		}
		
		public function render():void
		{
			_world.Step(_timeStep, _iterations);
		}
		
		private function init():void
		{
			var worldAABB:b2AABB = new b2AABB();
			worldAABB.lowerBound.Set(-100.0, -100.0);
			worldAABB.upperBound.Set(100.0, 100.0);
			
			var gravity:b2Vec2 = new b2Vec2(0.0, 10.0);
			var doSleep:Boolean = true;
			
			_world = new b2World(worldAABB, gravity, doSleep);
			
			_collisionListener = new PhysicsCollisionListener();
			_world.m_contactListener = _collisionListener;
		}
		
		private function initDebug():void
		{
			_debugSprite = new Sprite();
			
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			dbgDraw.m_sprite = _debugSprite;
			dbgDraw.m_drawScale = 30.0;
			dbgDraw.m_fillAlpha = 0.6;
			dbgDraw.m_lineThickness = 0;
			dbgDraw.m_drawFlags = 0x00ffffff;
			_world.SetDebugDraw(dbgDraw);
		}
	}
}