package com.vettigheid.engine.event
{
	public class GameEvent extends AbstractEvent
	{
		public static const BUILD:String = "Build the level";
		
		public function GameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}