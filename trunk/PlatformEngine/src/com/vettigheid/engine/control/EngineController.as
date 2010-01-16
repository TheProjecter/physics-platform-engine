package com.vettigheid.engine.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.vettigheid.engine.command.BuildLevelCommand;
	import com.vettigheid.engine.command.ExitHitCommand;
	import com.vettigheid.engine.command.ItemHitCommand;
	import com.vettigheid.engine.command.KeyboardCommand;
	import com.vettigheid.engine.command.LoadLevelXMLCommand;
	import com.vettigheid.engine.command.TrapHitCommand;
	import com.vettigheid.engine.event.ExitEvent;
	import com.vettigheid.engine.event.ItemEvent;
	import com.vettigheid.engine.event.KeyEvent;
	import com.vettigheid.engine.event.LevelEvent;
	import com.vettigheid.engine.event.TrapEvent;

	public class EngineController extends FrontController
	{
		public function EngineController()
		{
			initialise();
		}
		
		private function initialise():void
		{
			addCommand(ExitEvent.EXIT_HIT, ExitHitCommand);
			
			addCommand(ItemEvent.ITEM_HIT, ItemHitCommand);
			
			addCommand(KeyEvent.DOWN, KeyboardCommand);
			addCommand(KeyEvent.UP, KeyboardCommand);
			
			addCommand(LevelEvent.BUILD, BuildLevelCommand);
			addCommand(LevelEvent.LOAD_XML, LoadLevelXMLCommand);
			
			addCommand(TrapEvent.TRAP_HIT, TrapHitCommand);
		}
	}
}