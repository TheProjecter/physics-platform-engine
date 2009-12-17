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
			
			model.gameVO.player.physics = new PlayerPhysicsObject();
			physics.addObject("player", model.gameVO.player.physics);
			PlayerPhysicsObject(model.gameVO.player.physics).build(model.gameVO.player.position);
			
			var i:int = 1;
			for each(var enemyVO:EnemyValueObject in model.gameVO.enemies)
			{
				enemyVO.physics = new EnemyPhysicsObject();
				physics.addObject("enemy_" + i, enemyVO.physics);
				EnemyPhysicsObject(enemyVO.physics).build(enemyVO.position, enemyVO.minimal, enemyVO.maximal);
				
				physics.addCollision(new PhysicsCollision(model.gameVO.player.physics, enemyVO.physics, PhysicsCollision.ADD, PlayerPhysicsObject(model.gameVO.player.physics).collisionEnemyAddHandler));	
				
				i++;
			}
			
			physics.addCollision(new PhysicsCollision(model.gameVO.player.physics, levelPhysicsObject, PhysicsCollision.ADD, PlayerPhysicsObject(model.gameVO.player.physics).collisionFloorAddHandler));
			physics.addCollision(new PhysicsCollision(model.gameVO.player.physics, levelPhysicsObject, PhysicsCollision.PERSIST, PlayerPhysicsObject(model.gameVO.player.physics).collisionFloorPersistHandler));
			physics.addCollision(new PhysicsCollision(model.gameVO.player.physics, levelPhysicsObject, PhysicsCollision.REMOVE, PlayerPhysicsObject(model.gameVO.player.physics).collisionFloorRemoveHandler));
			
			model.gameVO.ready = true;
		}
	}
}