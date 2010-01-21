package net.sakri.flash.vector{
	import __AS3__.vec.Vector;
	
	import flash.geom.Point;

	public class Polygon{
		
		private var _closed:Boolean=false;
		
		public function Polygon(){
			_points=new Vector.<Point>();
			//_lines=new Vector.<Line>();
		}
		
		private var _anchor:Point;
		private var _points:Vector.<Point>;
		public function set points(p:Vector.<Point>):void{}
		public function get points():Vector.<Point>{return _points;}
		
		/*
		private var _lines:Vector.<Line>;
		public function set lines(l:Vector.<Line>):void{}
		public function get lines():Vector.<Line>{
			return _lines;
		}*/
		
		public function addPoint(p:Point):void{
			if(_closed)return;//throw error etc.
			if(!_points.length){
				_anchor=p;
			}else{
				//_lines.push(new Line(Point(_points[_points.length-1]),p));
			}
			_points.push(p);
		}
		
		public function getPointByIndex(index:uint):Point{
			if(index>points.length)throw new Error("Polygon.getPointByIndex() : index ["+index+"] out of points Array bounds Error");
			return Point(points[index]);
		}
		
		public function close():void{
			if(Point(_points[_points.length-1]).equals(_anchor))_points.pop();
			//_lines.push(new Line(Point(_points[_points.length-1]),_anchor));
			_closed=true;
		}

	}
}