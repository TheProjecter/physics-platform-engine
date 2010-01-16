package com.vettigheid.engine.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.vettigheid.engine.event.LevelEvent;

	public class ExitHitCommand extends AbstractCommand implements ICommand
	{
		public function ExitHitCommand()
		{
			super();
		}
		
		public function execute(event:CairngormEvent):void
		{
			model.gameVO.ready = false;
			model.physics.destroyAll();
			
			model.currentLevel += 1;
			
			var levelEvent:LevelEvent = new LevelEvent(LevelEvent.LOAD_XML);
			levelEvent.dispatch();
		}
	}
}