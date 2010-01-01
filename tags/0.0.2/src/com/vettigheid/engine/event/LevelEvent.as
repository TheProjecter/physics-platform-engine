package com.vettigheid.engine.event
{
	public class LevelEvent extends AbstractEvent
	{
		public static const BUILD:String = "Build the level";
		public static const LOAD:String = "Load the Level";
		
		public function LevelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}