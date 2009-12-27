package com.vettigheid.physics.objects
{
	import com.vettigheid.physics.component.AbstractPhysicsComponent;
	
	import flash.geom.Point;
	
	public class LevelPhysicsObject extends AbstractPhysicsComponent
	{
		public function LevelPhysicsObject()
		{
			super();
		}
		
		public function build(data:Array):void
		{
			this.position = new Point(0, 0);
			
			for(var i:int = 0; i < data.length; i++)
			{
				for(var j:int = 0; j < data[0].length; j++)
				{
					if(data[i][j] == 1)
					{
						// TODO: Make the tilesize a variable
						this.shape = this.createBox(model.tileSize, model.tileSize, j * model.tileSize + model.tileSize / 2, i * model.tileSize + model.tileSize / 2, 0, .5, .2, true);
					}
				}
			}
		}
	}
}