package com.vettigheid.engine.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.vettigheid.engine.command.BuildLevelCommand;
	import com.vettigheid.engine.command.LoadLevelCommand;
	import com.vettigheid.engine.event.LevelEvent;

	public class EngineController extends FrontController
	{
		public function EngineController()
		{
			initialise();
		}
		
		private function initialise():void
		{
			addCommand(LevelEvent.BUILD, BuildLevelCommand);
			addCommand(LevelEvent.LOAD, LoadLevelCommand);
		}
	}
}