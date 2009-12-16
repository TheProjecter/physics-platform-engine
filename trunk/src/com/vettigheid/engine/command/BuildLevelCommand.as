package com.vettigheid.engine.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.vettigheid.engine.view.GameView;
	import com.vettigheid.engine.vo.EnemyValueObject;
	import com.vettigheid.physics.PhysicsWrapper;
	import com.vettigheid.physics.collision.PhysicsCollision;
	import com.vettigheid.physics.objects.EnemyPhysicsObject;
	import com.vettigheid.physics.objects.LevelPhysicsObject;
	import com.vettigheid.physics.objects.PlayerPhysicsObject;
		
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
			
			var levelPhysicsObject:LevelPhysicsObject = new LevelPhysicsObject();
			physics.addObject("level", levelPhysicsObject);
			levelPhysicsObject.build(model.gameVO.level.tiles);
			
			var playerPhysicsObject:PlayerPhysicsObject = new PlayerPhysicsObject();
			physics.addObject("player", playerPhysicsObject);
			playerPhysicsObject.build(model.gameVO.player.position);
			
			for each(var enemyVO:EnemyValueObject in model.gameVO.enemies)
			{
				var enemyPhysicsObject:EnemyPhysicsObject = new EnemyPhysicsObject();
				physics.addObject("enemy", enemyPhysicsObject);
				enemyPhysicsObject.build(enemyVO.position, enemyVO.minimal, enemyVO.maximal);
				
				physics.addCollision(new PhysicsCollision(playerPhysicsObject, enemyPhysicsObject, PhysicsCollision.ADD, playerPhysicsObject.collisionEnemyAddHandler));	
			}
			
			physics.addCollision(new PhysicsCollision(playerPhysicsObject, levelPhysicsObject, PhysicsCollision.ADD, playerPhysicsObject.collisionFloorAddHandler));
			physics.addCollision(new PhysicsCollision(playerPhysicsObject, levelPhysicsObject, PhysicsCollision.PERSIST, playerPhysicsObject.collisionFloorPersistHandler));
			physics.addCollision(new PhysicsCollision(playerPhysicsObject, levelPhysicsObject, PhysicsCollision.REMOVE, playerPhysicsObject.collisionFloorRemoveHandler));
			
			model.gameVO.ready = true;
		}
	}
}