package com.vettigheid.engine.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.vettigheid.engine.view.LevelView;
	import com.vettigheid.physics.PhysicsWrapper;
	// import com.vettigheid.physics.component.LevelPhysicsComponent;

	public class BuildGameCommand extends AbstractCommand implements ICommand
	{
		public function BuildGameCommand()
		{
			super();
		}
		
		override public function execute(event:CairngormEvent):void
		{
			var levelView:LevelView = model.views.getView("levelView") as LevelView;
			var physics:PhysicsWrapper = model.physics;
			
			/*var levelPhysicsComponent:LevelPhysicsComponent = new LevelPhysicsComponent();
			physics.addComponent("levelPhysicsComponent", levelPhysicsComponent);*/
		}
	}
}