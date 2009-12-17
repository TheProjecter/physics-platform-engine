package com.vettigheid.physics.objects
{
	import com.vettigheid.physics.component.AbstractPhysicsComponent;
	
	import flash.geom.Point;
	
	public class ItemPhysicsObject extends AbstractPhysicsComponent
	{
		public function ItemPhysicsObject()
		{
		}
		
		public function build(position:Point):void
		{
			// Create a circle shape correspondening to the size of the item
			this.shape = this.createCircle(35, 1, 1, .1);	
		}
	}
}