package com.vettigheid.engine.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.vettigheid.engine.view.GameView;
	import com.vettigheid.physics.PhysicsWrapper;
	import com.vettigheid.physics.collision.PhysicsCollision;
	import com.vettigheid.physics.component.LevelPhysicsComponent;
	import com.vettigheid.physics.component.PlayerPhysicsComponent;
		
	public class BuildLevelCommand extends AbstractCommand implements ICommand
	{
		public function BuildLevelCommand()
		{
			super();
		}
		
		public function execute(event:CairngormEvent):void
		{
			var levelView:GameView = model.views.getView("levelView") as GameView;
			var physics:PhysicsWrapper = model.physics;
			
			var levelPhysicsComponent:LevelPhysicsComponent = new LevelPhysicsComponent();
			physics.addComponent("level", levelPhysicsComponent);
			levelPhysicsComponent.build(model.gameVO.level.tiles);
			
			var playerPhysicsComponent:PlayerPhysicsComponent = new PlayerPhysicsComponent();
			physics.addComponent("player", playerPhysicsComponent);
			playerPhysicsComponent.build(model.gameVO.player.position);
			
			physics.addCollision(new PhysicsCollision(playerPhysicsComponent, levelPhysicsComponent, PhysicsCollision.ADD, playerPhysicsComponent.collisionFloorAddHandler));
			physics.addCollision(new PhysicsCollision(playerPhysicsComponent, levelPhysicsComponent, PhysicsCollision.PERSIST, playerPhysicsComponent.collisionFloorPersistHandler));
			physics.addCollision(new PhysicsCollision(playerPhysicsComponent, levelPhysicsComponent, PhysicsCollision.REMOVE, playerPhysicsComponent.collisionFloorRemoveHandler));
			
			model.gameVO.ready = true;
		}
	}
}