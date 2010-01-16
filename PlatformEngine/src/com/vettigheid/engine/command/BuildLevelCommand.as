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
	import com.vettigheid.physics.objects.ExitPhysicsObject;
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
			
			var playerPhysicsObject:PlayerPhysicsObject = new PlayerPhysicsObject(model.gameVO.player.name);
			physics.addObject(model.gameVO.player.name, playerPhysicsObject);
			playerPhysicsObject.build(model.gameVO.player);
			
			var levelPhysicsObject:LevelPhysicsObject = new LevelPhysicsObject(model.gameVO.level.name);
			physics.addObject(model.gameVO.level.name, levelPhysicsObject);
			levelPhysicsObject.build(model.gameVO.level);
			
			physics.addCollision(model.gameVO.level.name, new PhysicsCollision(playerPhysicsObject, levelPhysicsObject, PhysicsCollision.ADD, playerPhysicsObject.collisionFloorAddHandler));
			physics.addCollision(model.gameVO.level.name, new PhysicsCollision(playerPhysicsObject, levelPhysicsObject, PhysicsCollision.PERSIST, playerPhysicsObject.collisionFloorPersistHandler));
			physics.addCollision(model.gameVO.level.name, new PhysicsCollision(playerPhysicsObject, levelPhysicsObject, PhysicsCollision.REMOVE, playerPhysicsObject.collisionFloorRemoveHandler));
			
			if(model.gameVO.clouds)
			{
				for each(var cloudVO:CloudValueObject in model.gameVO.clouds)
				{
					var cloudPhysicsObject:CloudPhysicsObject = new CloudPhysicsObject(cloudVO.name);
					physics.addObject(cloudVO.name, cloudPhysicsObject);
					cloudPhysicsObject.build(cloudVO);
					
					physics.addCollision(cloudVO.name, new PhysicsCollision(playerPhysicsObject, cloudPhysicsObject, PhysicsCollision.ADD, cloudPhysicsObject.collisionPlayerAddAndPersistHandler));
					physics.addCollision(cloudVO.name, new PhysicsCollision(playerPhysicsObject, cloudPhysicsObject, PhysicsCollision.PERSIST, cloudPhysicsObject.collisionPlayerAddAndPersistHandler));
					physics.addCollision(cloudVO.name, new PhysicsCollision(playerPhysicsObject, cloudPhysicsObject, PhysicsCollision.REMOVE, cloudPhysicsObject.collisionPlayerRemoveHandler));
				}
			}
			
			if(model.gameVO.elevators)
			{
				for each(var elevatorVO:ElevatorValueObject in model.gameVO.elevators)
				{
					var elevatorPhysicsObject:ElevatorPhysicsObject = new ElevatorPhysicsObject(elevatorVO.name);
					physics.addObject(elevatorVO.name, elevatorPhysicsObject);
					elevatorPhysicsObject.build(elevatorVO);
					
					physics.addCollision(elevatorVO.name, new PhysicsCollision(playerPhysicsObject, elevatorPhysicsObject, PhysicsCollision.ADD, elevatorPhysicsObject.collisionPlayerAddAndPersistHandler));
					physics.addCollision(elevatorVO.name, new PhysicsCollision(playerPhysicsObject, elevatorPhysicsObject, PhysicsCollision.PERSIST, elevatorPhysicsObject.collisionPlayerAddAndPersistHandler));
					physics.addCollision(elevatorVO.name, new PhysicsCollision(playerPhysicsObject, elevatorPhysicsObject, PhysicsCollision.REMOVE, elevatorPhysicsObject.collisionPlayerRemoveHandler));
				}
			}
			
			if(model.gameVO.enemies)
			{
				for each(var enemyVO:EnemyValueObject in model.gameVO.enemies)
				{
					var enemyPhysicsObject:EnemyPhysicsObject = new EnemyPhysicsObject(enemyVO.name);
					physics.addObject(enemyVO.name, enemyPhysicsObject);
					enemyPhysicsObject.build(enemyVO);
						
					physics.addCollision(enemyVO.name, new PhysicsCollision(playerPhysicsObject, enemyPhysicsObject, PhysicsCollision.ADD, enemyPhysicsObject.collisionPlayerAddHandler));	
				
				}
			}
			
			if(model.gameVO.exit)
			{
				var exitPhysicsObject:ExitPhysicsObject = new ExitPhysicsObject(model.gameVO.exit.name);
				physics.addObject(model.gameVO.exit.name, exitPhysicsObject);
				exitPhysicsObject.build(model.gameVO.exit);
				
				physics.addCollision(model.gameVO.exit.name, new PhysicsCollision(playerPhysicsObject, exitPhysicsObject, PhysicsCollision.ADD, exitPhysicsObject.collisionPlayerHandler));
			}
			
			if(model.gameVO.items)
			{
				for each(var itemVO:ItemValueObject in model.gameVO.items)
				{
					var itemPhysicsObject:ItemPhysicsObject = new ItemPhysicsObject(itemVO.name);
					physics.addObject(itemVO.name, itemPhysicsObject);
					itemPhysicsObject.build(itemVO);
					
					physics.addCollision(itemVO.name, new PhysicsCollision(playerPhysicsObject, itemPhysicsObject, PhysicsCollision.ADD, itemPhysicsObject.collisionPlayerHandler));
				}
			}
			
			if(model.gameVO.traps)
			{
				for each(var trapVO:TrapValueObject in model.gameVO.traps)
				{
					var trapPhysicsObject:TrapPhysicsObject = new TrapPhysicsObject(trapVO.name);
					physics.addObject(trapVO.name, trapPhysicsObject);
					trapPhysicsObject.build(trapVO);
					
					physics.addCollision(trapVO.name, new PhysicsCollision(playerPhysicsObject, trapPhysicsObject, PhysicsCollision.ADD, trapPhysicsObject.collisionPlayerHandler));
				}
			}
			
			model.gameVO.ready = true;
		}
	}
}