package com.vettigheid.engine.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.vettigheid.engine.command.BuildLevelCommand;
	import com.vettigheid.engine.command.ItemHitCommand;
	import com.vettigheid.engine.command.KeyboardCommand;
	import com.vettigheid.engine.command.LoadLevelXMLCommand;
	import com.vettigheid.engine.event.ItemEvent;
	import com.vettigheid.engine.event.KeyEvent;
	import com.vettigheid.engine.event.LevelEvent;

	public class EngineController extends FrontController
	{
		public function EngineController()
		{
			initialise();
		}
		
		private function initialise():void
		{
			addCommand(ItemEvent.ITEM_HIT, ItemHitCommand);
			
			addCommand(LevelEvent.BUILD, BuildLevelCommand);
			addCommand(LevelEvent.LOAD_XML, LoadLevelXMLCommand);
			
			addCommand(KeyEvent.DOWN, KeyboardCommand);
			addCommand(KeyEvent.UP, KeyboardCommand);
		}
	}
}