package com.vettigheid.engine.view
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	
	public class ViewManager
	{
		private var _views:Dictionary
		
		public function ViewManager()
		{			
			_views = new Dictionary(true);
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
		
		public function removeView(name:String):void
		{
			_views[name] = null;
		}
		
		public function showView(name:String):void
		{
			_views[name].visible = true;
		}
	}
}