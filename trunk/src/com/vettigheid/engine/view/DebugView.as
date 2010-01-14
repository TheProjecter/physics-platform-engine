package com.vettigheid.engine.view
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class DebugView extends AbstractView
	{
		private var _physicsDebugSprite:Sprite
		
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
		
		public function set position(value:Point):void
		{
			this.x = value.x;
			this.y = value.y;
		}
	}
}