package com.vettigheid.engine.model
{
	import com.adobe.cairngorm.model.IModelLocator;
	import com.vettigheid.engine.view.ViewManager;
	import com.vettigheid.engine.vo.LevelValueObject;
	import com.vettigheid.physics.PhysicsWrapper;

	[Bindable]
	public class ModelLocator implements IModelLocator
	{
		private static var _instance:ModelLocator
		
		public var debugMode:Boolean = true;
		public var levelVO:LevelValueObject;
		public var physics:PhysicsWrapper;
		public var views:ViewManager;
		
		public function ModelLocator(enforcer:SingletonEnforcer)
		{
			if(enforcer == null)
			{
				throw new Error("This class is a singleton and can only created once");
			}
		}
		
		public static function getInstance():ModelLocator
		{
			if(_instance == null)
			{
				_instance = new ModelLocator(new SingletonEnforcer);
			}
			
			return _instance;
		}
	}
}

class SingletonEnforcer{}