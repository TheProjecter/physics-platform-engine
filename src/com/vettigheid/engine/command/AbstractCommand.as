package com.vettigheid.engine.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.vettigheid.engine.model.ModelLocator;

	public class AbstractCommand implements ICommand
	{
		private var _model:ModelLocator;
		
		public function AbstractCommand()
		{
			_model = ModelLocator.getInstance();
		}
		
		public function execute(event:CairngormEvent):void
		{
		}
		
		protected function get model():ModelLocator
		{
			return _model;
		}
	}
}