package com.vettigheid.engine.view
{
	import flash.display.DisplayObject;
	
	public class ViewManager
	{
		private var _views:Array;
		
		public function ViewManager()
		{			
			_views = new Array();
		}

		public function addView(name:String, view:DisplayObject):void
		{
			_views[name] = view;
		}
		
		public function getView(name:String):DisplayObject
		{
			return _views[name];
		}
		
		public function hideView(name:String):void
		{
			_views[name].visible = false;
		}
		
		public function showView(name:String):void
		{
			_views[name].visible = true;
		}
	}
}