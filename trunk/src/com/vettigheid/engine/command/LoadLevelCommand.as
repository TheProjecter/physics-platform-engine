package com.vettigheid.engine.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.vettigheid.engine.event.LevelEvent;
	import com.vettigheid.engine.vo.EnemyValueObject;
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
			
			var playerVO:PlayerValueObject = new PlayerValueObject(new Point(260, 100));
			
			var enemies:Array = new Array();
			enemies.push(new EnemyValueObject(new Point(340, 320), new Point(300, 320), new Point(360, 320)));
			enemies.push(new EnemyValueObject(new Point(120, 320), new Point(80, 320), new Point(160, 320)));
			
			model.gameVO = new GameValueObject(levelVO, playerVO, enemies, new Array());
			
			var levelEvent:LevelEvent = new LevelEvent(LevelEvent.BUILD);
			levelEvent.dispatch();
		}
	}
}