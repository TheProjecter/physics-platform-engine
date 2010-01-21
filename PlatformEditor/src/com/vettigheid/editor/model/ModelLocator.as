package com.vettigheid.editor.model
{
	import com.adobe.cairngorm.model.IModelLocator;
	import com.vettigheid.editor.view.ViewManager;
	import com.vettigheid.editor.vo.TileTypeValueObject;
	
	import flash.display.NativeMenu;
	import flash.utils.Dictionary;

	[Bindable]
	public class ModelLocator implements IModelLocator
	{
		private static var _instance:ModelLocator

		public var debug:Boolean = true;
		public var menu:NativeMenu;
		public var _polygons:Number = 0;
		public var polygons:Dictionary = new Dictionary(true);
		public var tileCols:Number = 10;
		public var tileRows:Number = 10;
		public var tiles:Dictionary;
		public var tileSize:Number = 40;
		public var _tileType:TileTypeValueObject;
		public var tileTypes:Array;
		public var tools:Dictionary;
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