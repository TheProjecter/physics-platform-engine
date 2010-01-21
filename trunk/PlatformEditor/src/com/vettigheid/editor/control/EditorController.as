package com.vettigheid.editor.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.vettigheid.editor.command.GridBuildCommand;
	import com.vettigheid.editor.command.GridClickCommand;
	import com.vettigheid.editor.command.MenuBuildCommand;
	import com.vettigheid.editor.command.ToolsBuildCommand;
	import com.vettigheid.editor.command.ToolsClickCommand;
	import com.vettigheid.editor.event.GridEvent;
	import com.vettigheid.editor.event.MenuEvent;
	import com.vettigheid.editor.event.ToolsEvent;

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
			
			addCommand(MenuEvent.BUILD, MenuBuildCommand);
			
			addCommand(ToolsEvent.BUILD, ToolsBuildCommand);
			addCommand(ToolsEvent.CLICK, ToolsClickCommand);
		}
	}
}