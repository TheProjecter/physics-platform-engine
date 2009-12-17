package com.vettigheid.engine.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.vettigheid.engine.view.GameView;
	import com.vettigheid.engine.vo.EnemyValueObject;
	import com.vettigheid.engine.vo.ItemValueObject;
	import com.vettigheid.physics.PhysicsWrapper;
	import com.vettigheid.physics.collision.PhysicsCollision;
	import com.vettigheid.physics.objects.EnemyPhysicsObject;
	import com.vettigheid.physics.objects.ItemPhysicsObject;
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
			physics.addObject(model.gameVO.player.name, playerPhysicsObject);
			playerPhysicsObject.build(model.gameVO.player.position);
			
			physics.addCollision(new PhysicsCollision(playerPhysicsObject, levelPhysicsObject, PhysicsCollision.ADD, playerPhysicsObject.collisionFloorAddHandler));
			physics.addCollision(new PhysicsCollision(playerPhysicsObject, levelPhysicsObject, PhysicsCollision.PERSIST, playerPhysicsObject.collisionFloorPersistHandler));
			physics.addCollision(new PhysicsCollision(playerPhysicsObject, levelPhysicsObject, PhysicsCollision.REMOVE, playerPhysicsObject.collisionFloorRemoveHandler));
			
			for each(var enemyVO:EnemyValueObject in model.gameVO.enemies)
			{
				var enemyPhysicsObject:EnemyPhysicsObject = new EnemyPhysicsObject();
				physics.addObject(enemyVO.name, enemyPhysicsObject);
				enemyPhysicsObject.build(enemyVO.position, enemyVO.minimal, enemyVO.maximal);
				
				physics.addCollision(new PhysicsCollision(playerPhysicsObject, enemyPhysicsObject, PhysicsCollision.ADD, playerPhysicsObject.collisionEnemyAddHandler));	
			}
			
			for each(var itemVO:ItemValueObject in model.gameVO.items)
			{
				var itemPhysicsObject:ItemPhysicsObject = new ItemPhysicsObject();
				physics.addObject(itemVO.name, itemPhysicsObject);
				itemPhysicsObject.build(itemVO.position);
			}
			
			model.gameVO.ready = true;
		}
	}
}