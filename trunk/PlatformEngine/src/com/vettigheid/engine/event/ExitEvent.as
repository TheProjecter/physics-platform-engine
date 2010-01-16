package com.vettigheid.engine.event
{
	public class ExitEvent extends AbstractEvent
	{
		public static var EXIT_HIT:String = "Player hits an exit";
		
		public function ExitEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}