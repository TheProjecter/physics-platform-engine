package com.vettigheid.engine.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.vettigheid.physics.component.DynamicPhysicsComponent;

	public class TrapHitCommand extends AbstractCommand implements ICommand
	{
		public function TrapHitCommand()
		{
			super();
		}
		
		public function execute(event:CairngormEvent):void
		{
			DynamicPhysicsComponent(model.physics.getObject("Player"))._respawn = true;
		}
	}
}