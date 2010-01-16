package com.vettigheid.engine.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.vettigheid.engine.event.KeyEvent;

	public class KeyboardCommand extends AbstractCommand implements ICommand
	{
		// The key to toggle the debug view
		public static const D:Number = 68;
		
		public static const DOWN:Number = 40;
		public static const LEFT:Number = 37;
		public static const RIGHT:Number = 39;
		public static const UP:Number = 38;
		
		public function KeyboardCommand()
		{
			super();
		}
		
		public function execute(event:CairngormEvent):void
		{
			if(KeyEvent(event).type == KeyEvent.DOWN)
			{
				model.keys[KeyEvent(event).keyCode] = true;
				
				if(model.keys[KeyboardCommand.D] && model.debugMode)
				{
					if(model.views.getView("debugView").visible)
					{
						model.views.hideView("debugView");
					}
					else
					{
						model.views.showView("debugView");
					}
				}
			}
			
			if(KeyEvent(event).type == KeyEvent.UP)
			{
				model.keys[KeyEvent(event).keyCode] = false;
			}
		}
	}
}