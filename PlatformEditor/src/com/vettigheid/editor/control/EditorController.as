package com.vettigheid.editor.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.vettigheid.editor.command.GridBuildCommand;
	import com.vettigheid.editor.command.GridClickCommand;
	import com.vettigheid.editor.event.GridEvent;

	public class EditorController extends FrontController
	{
		public function EditorController()
		{
			initialise();
		}
		
		private function initialise():void
		{
			addCommand(GridEvent.BUILD, GridBuildCommand);
			addCommand(GridEvent.CLICK, GridClickCommand);
		}
	}
}