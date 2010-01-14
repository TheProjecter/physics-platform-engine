package com.vettigheid.engine.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.vettigheid.engine.event.LevelEvent;
	import com.vettigheid.engine.vo.CloudValueObject;
	import com.vettigheid.engine.vo.ElevatorValueObject;
	import com.vettigheid.engine.vo.EnemyValueObject;
	import com.vettigheid.engine.vo.GameValueObject;
	import com.vettigheid.engine.vo.ItemValueObject;
	import com.vettigheid.engine.vo.LevelValueObject;
	import com.vettigheid.engine.vo.PlayerValueObject;
	import com.vettigheid.engine.vo.TrapValueObject;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;

	public class LoadLevelXMLCommand extends AbstractCommand implements ICommand
	{
		public function LoadLevelXMLCommand()
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
			enemies.push(new EnemyValueObject("Enemy_1", new Point(80, 280), new Point(40, 280), new Point(120, 280)));
			//enemies.push(new EnemyValueObject("Enemy_2", new Point(320, 280), new Point(280, 280), new Point(360, 280)));
			
			var items:Dictionary = new Dictionary(true);
			items["Item_1"] = new ItemValueObject("Item_1", new Point(160, 240));
			
			var elevators:Array = new Array();
			elevators.push(new ElevatorValueObject("Elevator_1", new Point(160, 120), "horizontal", -1, 2));
			elevators.push(new ElevatorValueObject("Elevator_2", new Point(440, 120), "vertical", 0, 4));
			
			var traps:Array = new Array();
			traps.push(new TrapValueObject("Trap_1", new Point(600, 280)));
			traps.push(new TrapValueObject("Trap_2", new Point(640, 280)));
			traps.push(new TrapValueObject("Trap_3", new Point(680, 280)));
			
			var clouds:Array = new Array();
			clouds.push(new CloudValueObject("Cloud_1", new Point(320, 280)));
			
			model.gameVO = new GameValueObject(levelVO, playerVO, enemies, items, elevators, traps, clouds);
			
			var levelEvent:LevelEvent = new LevelEvent(LevelEvent.BUILD);
			levelEvent.dispatch();
		}
	}
}