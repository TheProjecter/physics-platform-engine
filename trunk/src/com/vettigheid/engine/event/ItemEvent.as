package com.vettigheid.engine.event
{
	public class ItemEvent extends AbstractEvent
	{
		public static var ITEM_HIT:String = "Player hits an item";
		
		public function ItemEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}