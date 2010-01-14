package com.vettigheid.physics.objects
{
	import Box2D.Collision.b2ContactPoint;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.Joints.b2PrismaticJoint;
	import Box2D.Dynamics.Joints.b2PrismaticJointDef;
	
	import com.vettigheid.engine.vo.ElevatorValueObject;
	import com.vettigheid.physics.component.DynamicPhysicsComponent;
	
	import flash.geom.Point;

	public class ElevatorPhysicsObject extends DynamicPhysicsComponent
	{
		private var _direction:String;
		private var _joint:b2PrismaticJoint;
		
		public function ElevatorPhysicsObject(name:String)
		{
			super(name);
		}
		
		public function build(vo:ElevatorValueObject):void
		{
			_direction = vo.direction;
			
			this.shape = this.createBox(model.tileSize, model.tileSize, 0, 0, 10, .5, .2);
			this.position = new Point(vo.position.x + (this.model.tileSize / 2), vo.position.y + (this.model.tileSize / 2));
			
			var prismJoint:b2PrismaticJointDef = new b2PrismaticJointDef();
			
			if(_direction == "horizontal")
			{
				prismJoint.Initialize(model.physics.groundBody, this.body, new b2Vec2((position.x + model.tileSize / 2) / 30, (position.y + model.tileSize / 2) / 30), new b2Vec2(1, 0));
			}
			
			if(_direction == "vertical")
			{
				prismJoint.Initialize(model.physics.groundBody, this.body, new b2Vec2((position.x + model.tileSize / 2) / 30, (position.y + model.tileSize / 2) / 30), new b2Vec2(0, 1));
			}
			
			prismJoint.lowerTranslation = (vo.minimal * this.model.tileSize) / 30;
			prismJoint.upperTranslation = (vo.maximal * this.model.tileSize) / 30;
			prismJoint.enableLimit = true;
			prismJoint.enableMotor = true;
			prismJoint.maxMotorForce = 400;
			prismJoint.motorSpeed = -1;
			prismJoint.collideConnected = true;
			_joint = model.physics.addJoint(prismJoint) as b2PrismaticJoint;
		}
		
		public function collisionPlayerAddAndPersistHandler(point:b2ContactPoint=null, contact:b2Contact=null, angle:Number=undefined):void
		{
			if(_direction == "horizontal")
			{
				if(((point.normal.x <= 1 && point.normal.x > 0) && (point.normal.y >= 0 && point.normal.y < 1)) || ((point.normal.x >= -1 && point.normal.x < 0) && (point.normal.y >= 0 && point.normal.y < 1)))
				{
					_joint.SetMotorSpeed(-_joint.GetMotorSpeed());
				}
				else
				{
					PlayerPhysicsObject(model.physics.getObject("Player")).grounded = true;
				}
			}
			
			if(_direction == "vertical")
			{
				if((point.normal.x > -1 && point.normal.x <= 0) && (point.normal.y > 0 && point.normal.y <= 1))
				{
					_joint.SetMotorSpeed(-_joint.GetMotorSpeed());
				}
				else
				{
					PlayerPhysicsObject(model.physics.getObject("Player")).grounded = true;
				}
			}
		}
		
		override public function move():void
		{
			if(_direction == "horizontal")
			{
				if(_joint.m_upperTranslation * 30 == Math.round(_joint.GetBody2().GetPosition().x * 30 - position.x))
				{
					_joint.SetMotorSpeed(-1);
				}
			
				if(_joint.m_lowerTranslation * 30 == Math.round(_joint.GetBody2().GetPosition().x * 30 - position.x))
				{
					_joint.SetMotorSpeed(1);
				}
			}
			
			if(_direction == "vertical")
			{
				if(_joint.m_upperTranslation * 30 == Math.round(_joint.GetBody2().GetPosition().y * 30 - position.y))
				{
					_joint.SetMotorSpeed(-1);
				}
			
				if(_joint.m_lowerTranslation * 30 == Math.round(_joint.GetBody2().GetPosition().y * 30 - position.y))
				{
					_joint.SetMotorSpeed(1);
				}
			}
		}
	}
}