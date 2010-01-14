package com.vettigheid.engine.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.vettigheid.engine.event.ItemEvent;
	import com.vettigheid.engine.vo.ItemValueObject;

	public class ItemHitCommand extends AbstractCommand implements ICommand
	{
		public function ItemHitCommand()
		{
			super();
		}
		
		public function execute(event:CairngormEvent):void
		{
			var itemEvent:ItemEvent = event as ItemEvent;
			
			model.physics.destroyObject(model.physics.getObject(itemEvent.name));
		}	
	}
}