package com.vettigheid.engine.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.vettigheid.engine.view.GameView;
	import com.vettigheid.engine.vo.CloudValueObject;
	import com.vettigheid.engine.vo.ElevatorValueObject;
	import com.vettigheid.engine.vo.EnemyValueObject;
	import com.vettigheid.engine.vo.ItemValueObject;
	import com.vettigheid.engine.vo.TrapValueObject;
	import com.vettigheid.physics.PhysicsWrapper;
	import com.vettigheid.physics.collision.PhysicsCollision;
	import com.vettigheid.physics.objects.CloudPhysicsObject;
	import com.vettigheid.physics.objects.ElevatorPhysicsObject;
	import com.vettigheid.physics.objects.EnemyPhysicsObject;
	import com.vettigheid.physics.objects.ItemPhysicsObject;
	import com.vettigheid.physics.objects.LevelPhysicsObject;
	import com.vettigheid.physics.objects.PlayerPhysicsObject;
	import com.vettigheid.physics.objects.TrapPhysicsObject;
		
	public class BuildLevelCommand extends AbstractCommand implements ICommand
	{
		public function BuildLevelCommand()
		{
			super();
		}
		
		public function execute(event:CairngormEvent):void
		{
			var gameView:GameView = model.views.getView("gameView") as GameView;
			gameView.gameWidth = model.gameVO.level.width * model.tileSize;
			gameView.gameHeight = model.gameVO.level.height * model.tileSize;
			
			var physics:PhysicsWrapper = model.physics;
			
			var levelPhysicsObject:LevelPhysicsObject = new LevelPhysicsObject("level");
			physics.addObject("level", levelPhysicsObject);
			levelPhysicsObject.build(model.gameVO.level.tiles);

			var playerPhysicsObject:PlayerPhysicsObject = new PlayerPhysicsObject(model.gameVO.player.name);
			physics.addObject(model.gameVO.player.name, playerPhysicsObject);
			playerPhysicsObject.build(model.gameVO.player.position);
			
			physics.addCollision(new PhysicsCollision(playerPhysicsObject, levelPhysicsObject, PhysicsCollision.ADD, playerPhysicsObject.collisionFloorAddHandler));
			physics.addCollision(new PhysicsCollision(playerPhysicsObject, levelPhysicsObject, PhysicsCollision.PERSIST, playerPhysicsObject.collisionFloorPersistHandler));
			physics.addCollision(new PhysicsCollision(playerPhysicsObject, levelPhysicsObject, PhysicsCollision.REMOVE, playerPhysicsObject.collisionFloorRemoveHandler));
			
			for each(var enemyVO:EnemyValueObject in model.gameVO.enemies)
			{
				var enemyPhysicsObject:EnemyPhysicsObject = new EnemyPhysicsObject(enemyVO.name);
				physics.addObject(enemyVO.name, enemyPhysicsObject);
				enemyPhysicsObject.build(enemyVO.position, enemyVO.minimal, enemyVO.maximal);
					
				physics.addCollision(new PhysicsCollision(playerPhysicsObject, enemyPhysicsObject, PhysicsCollision.ADD, enemyPhysicsObject.collisionPlayerAddHandler));	
			
			}
			
			for each(var itemVO:ItemValueObject in model.gameVO.items)
			{
				var itemPhysicsObject:ItemPhysicsObject = new ItemPhysicsObject(itemVO.name);
				physics.addObject(itemVO.name, itemPhysicsObject);
				itemPhysicsObject.build(itemVO.position);
				
				physics.addCollision(new PhysicsCollision(playerPhysicsObject, itemPhysicsObject, PhysicsCollision.ADD, itemPhysicsObject.collisionPlayerHandler));
			}
			
			for each(var elevatorVO:ElevatorValueObject in model.gameVO.elevators)
			{
				var elevatorPhysicsObject:ElevatorPhysicsObject = new ElevatorPhysicsObject(elevatorVO.name);
				physics.addObject(elevatorVO.name, elevatorPhysicsObject);
				elevatorPhysicsObject.build(elevatorVO);
				
				physics.addCollision(new PhysicsCollision(playerPhysicsObject, elevatorPhysicsObject, PhysicsCollision.ADD, playerPhysicsObject.collisionFloorAddHandler));
				physics.addCollision(new PhysicsCollision(playerPhysicsObject, elevatorPhysicsObject, PhysicsCollision.PERSIST, playerPhysicsObject.collisionFloorPersistHandler));
				physics.addCollision(new PhysicsCollision(playerPhysicsObject, elevatorPhysicsObject, PhysicsCollision.REMOVE, playerPhysicsObject.collisionFloorRemoveHandler));
			}
			
			for each(var trapVO:TrapValueObject in model.gameVO.traps)
			{
				var trapPhysicsObject:TrapPhysicsObject = new TrapPhysicsObject(trapVO.name);
				physics.addObject(trapVO.name, trapPhysicsObject);
				trapPhysicsObject.build(trapVO);
				
				physics.addCollision(new PhysicsCollision(playerPhysicsObject, trapPhysicsObject, PhysicsCollision.ADD, trapPhysicsObject.collisionPlayerHandler));
			}
			
			for each(var cloudVO:CloudValueObject in model.gameVO.clouds)
			{
				var cloudPhysicsObject:CloudPhysicsObject = new CloudPhysicsObject(cloudVO.name);
				physics.addObject(cloudVO.name, cloudPhysicsObject);
				cloudPhysicsObject.build(cloudVO);
				
				physics.addCollision(new PhysicsCollision(playerPhysicsObject, cloudPhysicsObject, PhysicsCollision.ADD, cloudPhysicsObject.collisionPlayerAddAndPersistHandler));
				physics.addCollision(new PhysicsCollision(playerPhysicsObject, cloudPhysicsObject, PhysicsCollision.PERSIST, cloudPhysicsObject.collisionPlayerAddAndPersistHandler));
				physics.addCollision(new PhysicsCollision(playerPhysicsObject, cloudPhysicsObject, PhysicsCollision.REMOVE, cloudPhysicsObject.collisionPlayerRemoveHandler));
			
				physics.addCollision(new PhysicsCollision(playerPhysicsObject, cloudPhysicsObject, PhysicsCollision.ADD, playerPhysicsObject.collisionFloorAddHandler));
				physics.addCollision(new PhysicsCollision(playerPhysicsObject, cloudPhysicsObject, PhysicsCollision.PERSIST, playerPhysicsObject.collisionFloorPersistHandler));
				physics.addCollision(new PhysicsCollision(playerPhysicsObject, cloudPhysicsObject, PhysicsCollision.REMOVE, playerPhysicsObject.collisionFloorRemoveHandler));
			}
			
			model.gameVO.ready = true;
		}
	}
}