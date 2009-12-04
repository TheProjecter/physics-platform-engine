package com.vettigheid.engine.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.vettigheid.engine.event.LevelEvent;
	import com.vettigheid.engine.vo.GameValueObject;
	import com.vettigheid.engine.vo.LevelValueObject;
	import com.vettigheid.engine.vo.PlayerValueObject;
	
	import flash.geom.Point;

	public class LoadLevelCommand extends AbstractCommand implements ICommand
	{
		public function LoadLevelCommand()
		{
			super();
		}
		
		public function execute(event:CairngormEvent):void
		{
			// TODO: Make the leveldata come from a XMLfile
			var tiles:Array = [
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
			];
			
			var levelVO:LevelValueObject = new LevelValueObject(tiles);
			
			var position:Point = new Point(260, 100);
			var playerVO:PlayerValueObject = new PlayerValueObject(position);
			
			model.gameVO = new GameValueObject(levelVO, playerVO);
			
			var levelEvent:LevelEvent = new LevelEvent(LevelEvent.BUILD);
			levelEvent.dispatch();
		}
	}
}