package com.vettigheid.engine.event
{
	public class LevelEvent extends AbstractEvent
	{
		public static const BUILD:String = "Build the level";
		public static const LOAD_GRAPHICS:String = "Load the Level Graphics";
		public static const LOAD_XML:String = "Load the Level XML";
		
		public function LevelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}