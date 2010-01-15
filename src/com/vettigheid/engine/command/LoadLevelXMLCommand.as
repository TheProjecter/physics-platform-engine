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
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class LoadLevelXMLCommand extends AbstractCommand implements ICommand
	{
		public function LoadLevelXMLCommand()
		{
			super();
		}
		
		public function execute(event:CairngormEvent):void
		{			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, handleXMLLoadComplete);
			loader.load(new URLRequest("data/levels.xml"));
		}
		
		private function handleXMLLoadComplete(e:Event):void
		{
			var i:int = 1;
			var xml:XML = new XML(e.target.data);
			
			for each(var level:XML in xml.children())
			{
				// TODO: Make PHP script to only load the neccesary level
				if(level.@id == 1)
				{
/** Level XML Parser **/
					
					// Parse the Tiles to a readable array for the LevelVO
					var tiles:Array = new Array();
					for each(var row:String in level.tiles.children())
					{
						tiles.push(row.split(","));
					}
					
					// Put the array with tiles in a LevelVO
					var levelVO:LevelValueObject = new LevelValueObject(tiles);
					
/** Player XML Parser **/

					var playerVO:PlayerValueObject = new PlayerValueObject(new Point(level.player.@x, level.player.@y));
				
/** Clouds XML Parser **/

					var clouds:Array = new Array();
					i = 1;
					for each(var cloud:XML in level.clouds.children())
					{
						clouds.push(new CloudValueObject("Cloud_" + i, new Point(cloud.@x, cloud.@y)));
						i++;
					}
					
					if(clouds.length == 0) clouds = null;
					
/** Elevators XML Parser **/

					var elevators:Array = new Array();
					i = 1;
					for each(var elevator:XML in level.elevators.children())
					{
						elevators.push(new ElevatorValueObject("Elevator_" + i, new Point(elevator.@x, elevator.@y), elevator.@direction, elevator.@min, elevator.@max));
						i++;
					}
					
					if(elevators.length == 0) elevators = null;
					
/** Enemies XML Parser **/

					var enemies:Array = new Array();
					i = 1;
					for each(var enemy:XML in level.enemies.children())
					{
						enemies.push(new EnemyValueObject("Enemy_" + i, new Point(enemy.@x, enemy.@y), new Point(enemy.@min_x, enemy.@min_y), new Point(enemy.@max_x, enemy.@max_y)));
						i++;
					}
					
					if(enemies.length == 0) enemies = null;
					
/** Items XML Parser **/
					
					var items:Array = new Array();
					i = 1;
					for each(var item:XML in level.items.children())
					{
						items.push(new ItemValueObject("Item_" + i, new Point(item.@x, item.@y)));
						i++;
					}
					
					if(items.length == 0) items = null;
					
/** Traps XML Parser **/

					var traps:Array = new Array();
					i = 1;
					for each(var trap:XML in level.traps.children())
					{
						traps.push(new TrapValueObject("Trap_" + i, new Point(trap.@x, trap.@y)));
						i++;
					}
					
					if(traps.length == 0) traps = null;
				}
			}
			
			//Put all object in a GameVO
			model.gameVO = new GameValueObject(levelVO, playerVO, clouds, elevators, enemies, items, traps);
			
			// Level is ready to be played, dispatch Ready Event
			var levelEvent:LevelEvent = new LevelEvent(LevelEvent.BUILD);
			levelEvent.dispatch();
		}
	}
}