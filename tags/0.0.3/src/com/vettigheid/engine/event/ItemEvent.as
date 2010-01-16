package com.vettigheid.engine.event
{
	public class ItemEvent extends AbstractEvent
	{
		public static var ITEM_HIT:String = "Player hits an item";
		
		private var _name:String;
		
		public function ItemEvent(type:String, name:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_name = name;
			
			super(type, bubbles, cancelable);
		}
		
		public function get name():String
		{
			return _name;
		}
	}
}