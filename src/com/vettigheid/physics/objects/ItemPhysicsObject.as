package com.vettigheid.physics.objects
{
	import com.vettigheid.physics.component.AbstractPhysicsComponent;
	
	import flash.geom.Point;
	
	public class ItemPhysicsObject extends AbstractPhysicsComponent
	{
		public function ItemPhysicsObject()
		{
			super();
		}
		
		public function build(position:Point):void
		{
			// Create a circle shape correspondening to the size of the item
			this.shape = this.createCircle(35, 0, 1, .1);	
			
			// Set the item to its position in the level
			this.position = position;
		}
	}
}