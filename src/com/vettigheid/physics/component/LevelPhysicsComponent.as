package com.vettigheid.physics.component
{
	import Box2D.Collision.Shapes.b2PolygonDef;
	
	public class LevelPhysicsComponent extends AbstractPhysicsComponent
	{
		public function LevelPhysicsComponent()
		{
			super(20, 20);
		}
		
		public function build(data:Array):void
		{
			for(var i:int = 0; i < data.length; i++)
			{
				for(var j:int = 0; j < data[0].length; j++)
				{
					if(data[i][j] == 1)
					{
						// TODO: Make the tilesize a variable
						this.shape = this.createBox(40, 40, j * 40, i * 40, 0, .5, .2, true);
					}
				}
			}
		}
	}
}