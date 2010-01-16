package com.vettigheid.engine.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.vettigheid.engine.model.ModelLocator;

	public class AbstractEvent extends CairngormEvent
	{
		protected var model:ModelLocator;
		
		public function AbstractEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			model = ModelLocator.getInstance();
			if(model.debugMode) trace("****** " + type + " ******");
		}
	}
}