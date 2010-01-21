package net.sakri.flash.vector{
	import __AS3__.vec.Vector;
	
	import flash.geom.Point;
	
	
	public class PolygonSegment{
		
		//since there are only 3 types, I didn't bother creating 3 sublasses.
		public static const LINE:String="Segment.line";
		public static const DIAGONAL:String="Segment.diagonal";
		public static const CURVE:String="Segment.curve";
		
		protected var _points:Vector.<Point>;
		public function set points(p:Vector.<Point>):void{
			this._start_point=Point(p[0]).clone();
			this._end_point=Point(p[p.length-1]).clone();
			_points=p;
		}
		public function get points():Vector.<Point>{
			return _points.slice();//TODO make sure this works...
		}
		public function clearPoints():void{
			_points=null;
		}
		
		protected var _type:String;
		public function set type(type:String):void{
			if(_type!=null)throw new Error("Segment ERROR : type is already set to : "+_type+" , new type:"+type);
			switch(type){
				case LINE:
				case DIAGONAL:
				case CURVE:
					_type=type;
					break;
				default:
					throw new Error("Segment set type ERROR : no such type : "+type);
			}
		}
		public function get type():String{
			return _type;
		}
		public function isTyped():Boolean{
			return _type!=null;
		}
		
		protected var _start_index:uint;
		public function get start_index():uint{return _start_index;}
		protected var _end_index:uint;
		public function get end_index():uint{return _end_index;}
		
		protected var _start_point:Point;
		public function get start_point():Point{return _start_point;}
		public function set start_point(p:Point):void{_start_point=p;}
		
		protected var _end_point:Point;
		public function get end_point():Point{return _end_point;}
		public function set end_point(p:Point):void{_end_point=p;}
				
		//seems a little stupid.. why would you need start and end index as params, if the vector of points is also passed?!
		public function PolygonSegment(start_index:uint,end_index:uint,points:Vector.<Point>=null,segment_type:String=null){
			if(points!=null)this.points=points;
			if(segment_type!=null)type=segment_type;
			_start_index=start_index;
			_end_index=end_index;
		}

		//rename... lame naming convention
		public function getBiggestPoint():Point{
			var biggest:Point=new Point();
			if(_points==null)throw new Error("PolygonSegment.getBiggestPoint ERROR : points are null");
			for each(var p:Point in _points){
				if(p.x>biggest.x)biggest.x=p.x;
				if(p.y>biggest.y)biggest.y=p.y;
			}
			return biggest;
		}
		
		public function toString():String{
			var stri:String="PolygonSegment{\n";
			stri+="\ttype:"+_type+",\n";
			stri+="\tstart_index:"+_start_index+",\n";
			stri+="\tend_index:"+_end_index+",\n";
			stri+="\tstart_point:"+_start_point+",\n";
			stri+="\tend_point:"+_end_point+"\n";
			stri+="}";
			return stri;
		}

	}
}