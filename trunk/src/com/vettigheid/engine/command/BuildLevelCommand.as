package com.vettigheid.engine.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.vettigheid.engine.view.GameView;
	import com.vettigheid.physics.PhysicsWrapper;
	import com.vettigheid.physics.component.LevelPhysicsComponent;
		
	public class BuildLevelCommand extends AbstractCommand implements ICommand
	{
		public function BuildLevelCommand()
		{
			super();
		}
		
		override public function execute(event:CairngormEvent):void
		{
			var levelView:GameView = model.views.getView("levelView") as GameView;
			var physics:PhysicsWrapper = model.physics;
			
			var levelPhysicsComponent:LevelPhysicsComponent = new LevelPhysicsComponent();
			physics.addComponent("levelPhysicsComponent", levelPhysicsComponent);
			
			levelPhysicsComponent.build(model.levelVO.tiles);
		}
	}
}