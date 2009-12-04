package com.vettigheid.engine.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.vettigheid.engine.event.LevelEvent;
	import com.vettigheid.engine.vo.LevelValueObject;

	public class LoadLevelCommand extends AbstractCommand implements ICommand
	{
		public function LoadLevelCommand()
		{
			super();
		}
		
		override public function execute(event:CairngormEvent):void
		{
			// TODO: Make the leveldata come from a XMLfile
			var tiles:Array = [
				[1, 1, 1, 1, 1, 1, 1, 1,],
				[1, 0, 0, 0, 0, 0, 0, 1,],
				[1, 0, 0, 0, 0, 0, 0, 1,],
				[1, 0, 0, 0, 0, 0, 0, 1,],
				[1, 0, 0, 0, 0, 0, 0, 1,],
				[1, 1, 1, 1, 1, 1, 1, 1,]
			];
			
			model.levelVO = new LevelValueObject(tiles);
			
			var levelEvent:LevelEvent = new LevelEvent(LevelEvent.BUILD);
			levelEvent.dispatch();
		}
	}
}