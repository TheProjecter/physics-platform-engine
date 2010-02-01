package com.vettigheid.physics
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2JointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	
	import com.vettigheid.physics.collision.PhysicsCollision;
	import com.vettigheid.physics.collision.PhysicsCollisionListener;
	import com.vettigheid.physics.component.AbstractPhysicsComponent;
	import com.vettigheid.physics.component.DynamicPhysicsComponent;
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	public class PhysicsWrapper
	{
		private var _collisionListener:PhysicsCollisionListener;
		private var _components:Dictionary;
		private var _debug:Boolean;
		private var _debugSprite:Sprite;
		private var _iterations:int = 10;
		private var _timeStep:Number = 1.0 / 30.0;
		private var _world:b2World;
		
		public function PhysicsWrapper(debug:Boolean=false)
		{
			_debug = debug;
			
			init();
			if(_debug) initDebug(); 
			
			_components = new Dictionary(true);
		}
		
		public function get components():Dictionary
		{
			return _components;
		}
		
		public function get debugSprite():Sprite
		{
			return _debugSprite;
		}

		public function get groundBody():b2Body
		{
			return _world.GetGroundBody();
		}

		public function addCollision(name:String, collision:PhysicsCollision):void
		{
			_collisionListener.addCollision(name, collision);
		}
		
		public function addJoint(jointDef:b2JointDef):b2Joint
		{
			return _world.CreateJoint(jointDef);
		}

		public function addObject(name:String, component:AbstractPhysicsComponent):void
		{
			component.body = _world.CreateBody(component.bodydef);
			_components[name] = component;
		}
		
		public function destroyAll():void
		{
			for(var key:Object in _components)
			{
				// _world.m_lock = false;
				_world.DestroyBody(_components[key].body);
				_collisionListener.removeCollisions(String(key));
				_components[key] = null;
				delete _components[key];
			}
		}
		
		public function destroyObject(component:AbstractPhysicsComponent):void
		{
			for(var key:Object in _components)
			{
				if(_components[key] == component)
				{
					// _world.m_lock = false;
					_world.DestroyBody(_components[key].body);
					_collisionListener.removeCollisions(String(key));
					_components[key] = null;
					delete _components[key];
				}
			}
		}
		
		public function getObject(name:String):AbstractPhysicsComponent
		{
			return _components[name];
		}
		
		public function render():void
		{
			for each(var component:AbstractPhysicsComponent in _components)
			{
				if(component is DynamicPhysicsComponent)
				{
					DynamicPhysicsComponent(component).move();
					
					if(DynamicPhysicsComponent(component)._respawn)
					{
						DynamicPhysicsComponent(component).respawn();
					}
				}
			}
			
			_world.Step(_timeStep, 10, _iterations);
			_world.ClearForces();
			if(_debug) _world.DrawDebugData();
		}
		
		private function init():void
		{
			var gravity:b2Vec2 = new b2Vec2(0.0, 10.0);
			var doSleep:Boolean = true;
			
			_world = new b2World(gravity, doSleep);
			
			_collisionListener = new PhysicsCollisionListener();
			_world.SetContactListener(_collisionListener);
		}
		
		private function initDebug():void
		{
			_debugSprite = new Sprite();
			
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			
			dbgDraw.SetSprite(_debugSprite);
			
			dbgDraw.SetDrawScale(30.0);
			dbgDraw.SetAlpha(1);
			dbgDraw.SetFillAlpha(0.6);
			dbgDraw.SetLineThickness(1);
			dbgDraw.SetFlags(b2DebugDraw.e_shapeBit);
			_world.SetDebugDraw(dbgDraw);
		}
	}
}