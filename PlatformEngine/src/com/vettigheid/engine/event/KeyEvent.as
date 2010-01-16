package com.vettigheid.engine.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class KeyEvent extends CairngormEvent
	{
		public static const DOWN:String = "Key is Down";
		public static const UP:String = "Key is Released";
		
		private var _keyCode:Number;
		
		public function KeyEvent(type:String, keyCode:Number, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			_keyCode = keyCode;
		}
		
		public function get keyCode():Number
		{
			return _keyCode;
		}
	}
}