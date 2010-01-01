package com.vettigheid.engine.view
{
	import flash.display.Sprite;
	
	public class DebugView extends AbstractView
	{
		private var _physicsDebugSprite:Sprite;
		
		public function DebugView()
		{
			
		}
		
		public function set physicsDebugSprite(value:Sprite):void
		{
			_physicsDebugSprite = value;
			
			if(model.debugMode)
			{
				this.addChild(_physicsDebugSprite);
			}
		}
	}
}