package net.sakri.flash.vector{
	import __AS3__.vec.Vector;
	
	import flash.display.GraphicsPathCommand;
	import flash.geom.Point;
	
	
	public class DrawAPIUtil{
		
		public static function getDrawPathVOFromPointsVector(points:Vector.<Point>):DrawPathVO{
			var data:Vector.<Number>=new Vector.<Number>();
			var commands:Vector.<int>=new Vector.<int>();
			var p:Point=points[0];
			data.push(p.x,p.y);
			commands[0]=GraphicsPathCommand.MOVE_TO;
			var tot:uint=points.length;
			for(var i:uint=1;i<tot;i++){
				p=points[i];
				data.push(p.x,p.y);
				commands.push(GraphicsPathCommand.LINE_TO);
			}
			p=points[0];
			data.push(p.x,p.y);
			commands.push(GraphicsPathCommand.LINE_TO);
			return new DrawPathVO(commands,data);
		}

	}
}