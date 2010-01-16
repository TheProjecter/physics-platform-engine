package com.vettigheid.physics.objects
{
	import com.vettigheid.engine.vo.AbstractValueObject;
	import com.vettigheid.engine.vo.LevelValueObject;
	import com.vettigheid.physics.component.AbstractPhysicsComponent;
	
	import flash.geom.Point;
	
	public class LevelPhysicsObject extends AbstractPhysicsComponent
	{
		public function LevelPhysicsObject(name:String)
		{
			super(name);
		}
		
		override public function build(vo:AbstractValueObject):void
		{
			this.position = new Point(0, 0);
			
			for(var i:int = 0; i < LevelValueObject(vo).tiles.length; i++)
			{
				for(var j:int = 0; j < LevelValueObject(vo).tiles[0].length; j++)
				{
					switch(Number(LevelValueObject(vo).tiles[i][j]))
					{
						case 1:
							this.shape = this.createBox(model.tileSize, model.tileSize, j * model.tileSize + model.tileSize / 2, i * model.tileSize + model.tileSize / 2, 0, .5, .2, true);
						break;
						
						case 2:
							var shape_2:Array = new Array();
							shape_2.push(new Point(0, model.tileSize));
							shape_2.push(new Point(model.tileSize, model.tileSize / 2));
							shape_2.push(new Point(model.tileSize, model.tileSize));
							this.shape = this.createPoly(shape_2, j * model.tileSize, i * model.tileSize, 0, .5, .2);	
						break;
						
						case 3:
							var shape_3:Array = new Array();
							shape_3.push(new Point(0, model.tileSize / 2));
							shape_3.push(new Point(model.tileSize, 0));
							shape_3.push(new Point(model.tileSize, model.tileSize));
							shape_3.push(new Point(0, model.tileSize));
							this.shape = this.createPoly(shape_3, j * model.tileSize, i * model.tileSize, 0, .5, .2);	
						break;
						
						case 4:
							var shape_4:Array = new Array();
							shape_4.push(new Point(0, 0));
							shape_4.push(new Point(model.tileSize, model.tileSize / 2));
							shape_4.push(new Point(model.tileSize, model.tileSize));
							shape_4.push(new Point(0, model.tileSize));
							this.shape = this.createPoly(shape_4, j * model.tileSize, i * model.tileSize, 0, .5, .2);	
						break;
						
						case 5:
							var shape_5:Array = new Array();
							shape_5.push(new Point(0, model.tileSize / 2));
							shape_5.push(new Point(model.tileSize, model.tileSize));
							shape_5.push(new Point(0, model.tileSize));
							this.shape = this.createPoly(shape_5, j * model.tileSize, i * model.tileSize, 0, .5, .2);	
						break;
					}
				}
			}
		}
	}
}