package com.vettigheid.engine.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.vettigheid.engine.event.LevelEvent;
	import com.vettigheid.engine.vo.ElevatorValueObject;
	import com.vettigheid.engine.vo.EnemyValueObject;
	import com.vettigheid.engine.vo.GameValueObject;
	import com.vettigheid.engine.vo.ItemValueObject;
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
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 3, 1, 0, 0, 0, 1, 4, 5, 0, 0, 1],
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
			];
			
			var levelVO:LevelValueObject = new LevelValueObject(tiles);
			
			var playerVO:PlayerValueObject = new PlayerValueObject("Player", new Point(40, 80));
			
			var enemies:Array = new Array();
			enemies.push(new EnemyValueObject("Enemy_1", new Point(320, 280), new Point(280, 280), new Point(360, 280)));
			enemies.push(new EnemyValueObject("Enemy_2", new Point(80, 280), new Point(40, 280), new Point(120, 280)));
			
			var items:Array = new Array();
			items.push(new ItemValueObject("Item_1", new Point(160, 240)));
			
			var elevators:Array = new Array();
			elevators.push(new ElevatorValueObject("Elevator_1", new Point(160, 120), "horizontal", -1, 2));
			elevators.push(new ElevatorValueObject("Elevator_2", new Point(440, 120), "vertical", 0, 4));
			
			model.gameVO = new GameValueObject(levelVO, playerVO, enemies, items, elevators);
			
			var levelEvent:LevelEvent = new LevelEvent(LevelEvent.BUILD);
			levelEvent.dispatch();
		}
	}
}