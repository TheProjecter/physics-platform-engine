package com.vettigheid.engine.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.vettigheid.engine.event.KeyEvent;
	import com.vettigheid.physics.objects.PlayerPhysicsObject;

	public class KeyboardCommand extends AbstractCommand implements ICommand
	{
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
			var e:KeyEvent = event as KeyEvent;
			var player:PlayerPhysicsObject = model.physics.getObject("player") as PlayerPhysicsObject;
			
			if(e.type == KeyEvent.DOWN)
			{
				model.keys[e.keyCode] = true;
			}
			
			if(e.type == KeyEvent.UP)
			{
				model.keys[e.keyCode] = false;
			}
		}
	}
}