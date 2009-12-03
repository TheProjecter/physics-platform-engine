package com.vettigheid.engine.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.vettigheid.engine.command.BuildGameCommand;
	import com.vettigheid.engine.event.GameEvent;

	public class EngineController extends FrontController
	{
		public function EngineController()
		{
			initialise();
		}
		
		private function initialise():void
		{
			addCommand(GameEvent.BUILD, BuildGameCommand);
		}
	}
}