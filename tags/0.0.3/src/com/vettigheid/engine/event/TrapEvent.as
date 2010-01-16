package com.vettigheid.engine.event
{
	public class TrapEvent extends AbstractEvent
	{
		public static var TRAP_HIT:String = "Player hits a trap";
		
		public function TrapEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}