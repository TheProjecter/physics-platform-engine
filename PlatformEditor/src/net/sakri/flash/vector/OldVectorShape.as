package net.sakri.flash.vector{
	import __AS3__.vec.Vector;
	
	import flash.geom.Point;
	
	import net.sakri.flash.math.MathUtil;
	import net.sakri.flex.component.FlexSimpleTraceBox;
	
	public class VectorShape{

		protected var _break_points:Vector.<Point>;		
		public function set break_points(bp:Vector.<Point>):void{
			_break_points=bp;
		}
		public function get break_points():Vector.<Point>{
			return _break_points;
		}

		protected var _lines:Vector.<VectorLine>;				
		public function set lines(comps:Vector.<VectorLine>):void{
			_lines=comps;
		}
		public function get lines():Vector.<VectorLine>{
			return _lines;
		}

		protected var _curve_accuracy:uint;
		
		public function VectorShape(curve_accuracy:uint=10){
			_curve_accuracy=curve_accuracy;
		}
		
		protected function orderBreakPoints():void{
			var ordered:Vector.<Point>=new Vector.<Point>();
			var i:uint,j:uint;
			var line:VectorLine;
			var point:Point;
			outer:for(i=0;i<_lines.length;i++){
				line=VectorLine(_lines[i]);
				inner:for(j=0;j<_break_points.length;j++){
					if(Point(_break_points[j]).equals(line.start_point)){
						ordered.push(_break_points.splice(j,1)[0]);
						break inner;
					}
				}
			}
			if(_break_points.length){
				throw new Error("VectorShape Error : orderBreakPoints() ordering failed");
				return;				
			}else{
				_break_points=ordered;
			}
		}

		/*
		protected function removeShortBreakPoints():void{
			var prev:Point=_break_points[_break_points.length-1];
			var cur:Point;
			for(var i:int=_break_points.length-2;i>-1;i--){
				cur=_break_points[i];
				if(Point.distance(cur,prev)==1){
					
				}
			}
		}*/
		
		public function optimizeUsingBreakPoints():void{
			//failsafe
			
			if(_break_points==null){
				throw new Error("VectorShape Error : optimizeUsingBreakPoints() null _break_points");
				return;
			}
			orderBreakPoints();
			//removeShortBreakPoints();
			var line:VectorLine;
			var last_bp_index:uint=0;
			var anchor:uint=0;
			var bp_index:uint=1;
			var optimized_lines:Vector.<VectorLine>=new Vector.<VectorLine>();
			//FlexSimpleTraceBox.trace("_break_points.length : "+_break_points.length);
			var breaks_copy:Vector.<Point>=_break_points.slice();
			breaks_copy.push(_break_points[0]);
			var lines_copy:Vector.<VectorLine>=_lines.slice();
			lines_copy.push(_lines[0]);
			for(var i:uint=1;i<lines_copy.length;i++){
				line=lines_copy[i];
				if(line.start_point.equals(breaks_copy[bp_index])){
					if(i-anchor==1){
						FlexSimpleTraceBox.trace("***H or V Line");
						optimized_lines.push(lines_copy[i-1]);
					}else{
						if(isDiagonal(lines_copy,anchor,i)){
							FlexSimpleTraceBox.trace("***Diagonal");
							optimized_lines.push(mergeLines(VectorLine(lines_copy[anchor]),line));
						}else{
							FlexSimpleTraceBox.trace("***Complex Segment");
							optimized_lines=optimized_lines.concat(handleComplexSegment(lines_copy,anchor,i));//might throw error!
						}
					}
					anchor=i;
					bp_index++;
					if(bp_index>=breaks_copy.length)break;
				}
			}
			FlexSimpleTraceBox.trace("optimized_lines.length : "+optimized_lines.length);
			_lines=optimized_lines;
		}

		//should the second be the end point?!
		protected function mergeLines(line1:VectorLine,line2:VectorLine):VectorLine{
			return new VectorLine(line1.index,line1.start_point,line2.start_point,0);
		}

		protected function getMiddlePointInVLineSegment(lines_vect:Vector.<VectorLine>,index1:uint,index2:uint):Point{
			var mid_index:uint=Math.round(index1+(index2-index1)/2);
			return VectorLine(lines_vect[mid_index]).start_point;		
		}
		
		protected var _diagonal_buffer:Number=.15;//should be smaller?!
		protected function isDiagonal(lines_vect:Vector.<VectorLine>,index1:uint,index2:uint):Boolean{
			var first:Point=VectorLine(lines_vect[index1]).start_point;
			var middle:Point=getMiddlePointInVLineSegment(lines_vect,index1,index2);
			var last:Point=VectorLine(lines_vect[index2]).start_point;
			var diff:Number=Point.distance(first,last)-Point.distance(first,middle)-Point.distance(middle,last);
			//FlexSimpleTraceBox.trace("isDiagonal()"+diff);
			return Math.abs(diff)<_diagonal_buffer;
		}
	
		protected function lessThanOrEqual(a:uint,b:uint):Boolean{
			return a<=b;
		}
		protected function greaterThanOrEqual(a:uint,b:uint):Boolean{
			return a>=b;
		}
	
		/*
		//Logic is flawed, thanks to "fake" non embedded font
		protected function isSimpleCurve(lines_vect:Vector.<VectorLine>,index1:uint,index2:uint):Boolean{
			if(index2-index1<3)return false;//too short
			var odd:uint;
			var even:uint;
			if(index1%2){
				odd=VectorLine(lines_vect[index1]).length;
				even=VectorLine(lines_vect[index2]).length;
			}else{
				even=VectorLine(lines_vect[index1]).length;
				odd=VectorLine(lines_vect[index2]).length;
			}
			var odd_func:Function;
			var even_func:Function;
			var cur_length:Number;
			//set odd and even based on index1%2 and index2%2 !!!!
			if(odd>even){
				odd_func=lessThanOrEqual;
				even_func=greaterThanOrEqual;
			}else{
				odd_func=greaterThanOrEqual;
				even_func=lessThanOrEqual;
			}
			FlexSimpleTraceBox.trace("isSimpleCurve() lines:"+(index2-index1));
			for(var i:uint=index1+2;i<index2;i++){
				FlexSimpleTraceBox.trace("\ti:"+(i-index1)+" even:"+even+" , odd:"+odd);
				cur_length=VectorLine(lines_vect[i]).length;
				if(i%2){
					if(!odd_func(cur_length,odd))return false;
					odd=cur_length;
				}else{
					if(!even_func(cur_length,even))return false;
					even=cur_length;
				}
			}
			return true;
		}*/
		
		protected function isComplexDiagonal(lines_vect:Vector.<VectorLine>,index1:uint,index2:uint):Boolean{
			return false;
		}
	
		
	
		protected var _min_curve_short_line:uint=5;//test with 4 even 3...
	
		protected function containsStairs(lines_vect:Vector.<VectorLine>,index1:uint,index2:uint):Boolean{
			for(var i:uint=index1;i<index2-1;i++){
				if(	VectorLine(lines_vect[i]).length>_min_curve_short_line && 
					VectorLine(lines_vect[i+1]).length>_min_curve_short_line){
					return true;
				}
			}
			return false;
		}
		
		protected function handleComplexSegment(lines:Vector.<VectorLine>,index1:uint,index2:uint):Vector.<VectorLine>{
			var curve_lines:Vector.<VectorLine>=new Vector.<VectorLine>();
			var sub_lines:Vector.<VectorLine>=new Vector.<VectorLine>();
			//var sub_lines:Vector.<VectorLine>=getSubLines(lines:Vector.<VectorLine>,index1:uint,index2:uint);
			//if(sub_lines.length)return sub_lines;
			/*
			if(containsStairs(lines,index1,index2)){
				FlexSimpleTraceBox.trace("$$$ CONTAINS STAIRS $$$$$");
				if(index2-index1==2){
					//FlexSimpleTraceBox.trace("\tSimple step");
					curve_lines[0]=lines[index1];
					curve_lines[1]=lines[index1+1];
					return curve_lines;
				}else{
					FlexSimpleTraceBox.trace("\tNested step index1-index2: "+index1+"-"+index2+"="+(index1-index2));
					//handleNestedSteps()
				}
			}*/
			//Y bug (stair with line and diagonal)
			sub_lines=getLineDiagonalCombo(lines,index1,index2);
			if(sub_lines.length){
				return sub_lines;
			}
			
			//handleStairs(lines,index1,index2);			
			//var mid_point:Point=this.getMiddlePointInVLineSegment(lines,index1,index2);
			//return getVectorLinesInCurve(VectorLine(lines[index1]).start_point,mid_point,VectorLine(lines[index2]).start_point);
			return getVectorLinesInCurve2(lines,index1,index2);
		}
		
		protected function getLineDiagonalCombo(lines:Vector.<VectorLine>,index1:uint,index2:uint):Vector.<VectorLine>{
			var found:Vector.<VectorLine>=new Vector.<VectorLine>();
			if(isDiagonal(lines,index1+1,index2) && VectorLine(lines[index1]).length>this._curve_accuracy){
				FlexSimpleTraceBox.trace("getLineDiagonalCombo() Flavor1");
				found[0]=VectorLine(lines[index1]);
				found[1]=new VectorLine(0,VectorLine(lines[index1+1]).start_point,VectorLine(lines[index2]).start_point,0);
			}
			if(isDiagonal(lines,index1,index2-1) && VectorLine(lines[index2-1]).length>this._curve_accuracy){
				FlexSimpleTraceBox.trace("getLineDiagonalCombo() Flavor2");
				found[0]=new VectorLine(0,VectorLine(lines[index1]).start_point,VectorLine(lines[index2-1]).start_point,0);
				found[1]=VectorLine(lines[index2-1]);
			}
			if(found.length){
				FlexSimpleTraceBox.trace("FOUND LINE DIAGONAL COMBO!!\n"+found[0]+"\n"+found[1]);
				
			}
			return found;
		}
		
		protected function handleStairs(lines:Vector.<VectorLine>,index1:uint,index2:uint):void{
			FlexSimpleTraceBox.trace("handleStairs() i1:"+index1+" , i2:"+index2);
			var cur:VectorLine;
			var compare:VectorLine;
			var proportion:Number;
			var isolated_long_lines:Array=new Array();
			var isolated_long_found:Boolean=false;
			var i:int,j:int,limit:uint;
			for(i=index1;i<index2;i++){
				isolated_long_found=false;
				cur=VectorLine(lines[i]);
				if(cur.length>this._curve_accuracy){
					limit=Math.max(i-3,index1);
					before_loop:for(j=limit;j<i;j++){
						FlexSimpleTraceBox.trace("before loop"+j);
						compare=VectorLine(lines[j]);
						proportion=compare.length/cur.length;
						if(proportion<.75 || proportion>1.25){
							isolated_long_found=true;
							break before_loop;
						}
					}
					limit=Math.min(i+3,index2);
					after_loop:for(j=i;j<limit;j++){
						FlexSimpleTraceBox.trace("after loop"+j);
						compare=VectorLine(lines[j]);
						proportion=compare.length/cur.length;
						if(proportion<.75 || proportion>1.25){
							isolated_long_found=true;
							break after_loop;
						}
					}
				}
				if(isolated_long_found){
					FlexSimpleTraceBox.trace("handleStairs() ISOLATED LONG FOUND");
					isolated_long_lines.push(cur);
				}
			}
		}

		protected function getVectorLinesInCurve2(lines:Vector.<VectorLine>,index1:uint,index2:uint):Vector.<VectorLine>{
			var found:Vector.<VectorLine>=new Vector.<VectorLine>();
			var anchor:uint=index1;
			var line:VectorLine;
			for(var i:uint=index1+1;i<index2;i++){
				if(Point.distance(VectorLine(lines[anchor]).start_point,VectorLine(lines[i]).start_point)>_curve_accuracy){
					line=new VectorLine(0,VectorLine(lines[anchor]).start_point,VectorLine(lines[i]).start_point,0);
					found.push(line);
					anchor=i
				}
			}
			if(line==null){
				found.push(new VectorLine(0,VectorLine(lines[index1]).start_point,VectorLine(lines[index2]).start_point,0));
				return found;
			}
			if(!line.end_point.equals(VectorLine(lines[index2]).start_point)){
				if(Point.distance(line.end_point,VectorLine(lines[index2]).start_point)<_curve_accuracy){
					line.end_point=VectorLine(lines[index2]).start_point;
				}else{
					found.push(new VectorLine(0,line.end_point,VectorLine(lines[index2]).start_point,0));
				}
			}
			return found;
		}


		protected var pi_sqrt2:Number=Math.PI*Math.SQRT2;//static const, or move to MathUtil?!
		
		protected function getVectorLinesInCurve(start_point:Point,mid_point:Point,end_point:Point):Vector.<VectorLine>{
			//4 possibilities
			var start_angle:Number;
			var direction:int;//1 for clockwise, -1 for counter clockwise
			var h_radius:Number=Math.abs(start_point.x-end_point.x);
			var v_radius:Number=Math.abs(start_point.y-end_point.y);
			var ellipse_circumference:Number=MathUtil.getCircumeferenceOfEllipse(h_radius*2, v_radius*2 );
			var ellipse_center:Point;
			var curve_length:Number=ellipse_circumference/4;
			if(curve_length<this._curve_accuracy)return Vector.<VectorLine>([new VectorLine(0,start_point,end_point,0)]);
			
			var angle_increment:Number=360/(ellipse_circumference/this._curve_accuracy);
			var increments:uint=Math.ceil(90/angle_increment);
			/*
			FlexSimpleTraceBox.trace("\ngetVLinesInCurve()");
			FlexSimpleTraceBox.trace("start_point:"+start_point+" ,end_point:"+end_point);
			FlexSimpleTraceBox.trace("DIST : "+Point.distance(start_point,end_point));
			FlexSimpleTraceBox.trace("curve_length : "+curve_length);
			FlexSimpleTraceBox.trace("angle_increment : "+angle_increment);
			FlexSimpleTraceBox.trace("increments : "+increments);
			*/
			//these angles are used to determine the direction and start angle
			var angle_start_mid:Number=Math.atan2(mid_point.y-start_point.y,mid_point.x-start_point.x);
			var angle_start_end:Number=Math.atan2(end_point.y-start_point.y,end_point.x-start_point.x);
			
			//MOVE TO flash.math.ellipse or so...
			if(start_point.y<end_point.y){
				if(start_point.x<end_point.x){
					if(angle_start_mid>angle_start_end){
						//Reverse O curve 2
						direction=-1;
						start_angle=180;	
						ellipse_center=new Point(end_point.x,start_point.y);
					}else{
						//O curve 1
						direction=1;
						start_angle=270;
						ellipse_center=new Point(start_point.x,end_point.y);
					}
				}else{
					if(angle_start_mid>angle_start_end){
						//Reverse O curve 1
						direction=-1;
						start_angle=270;	
						ellipse_center=new Point(start_point.x,end_point.y);
					}else{
						//O curve 2
						direction=1;
						start_angle=0;
						ellipse_center=new Point(end_point.x,start_point.y);
					}
				}
			}else{
				if(start_point.x<end_point.x){
					if(angle_start_mid>angle_start_end){
						//Reverse O curve 3
						direction=-1;
						start_angle=90;
						ellipse_center=new Point(start_point.x,end_point.y);
					}else{
						//O curve 4
						direction=1;
						start_angle=180;
						ellipse_center=new Point(end_point.x,start_point.y);
					}				
				}else{
					if(angle_start_mid>angle_start_end){
						//Reverse O curve 4
						direction=-1;
						start_angle=0;	
						ellipse_center=new Point(end_point.x,start_point.y);
					}else{
						//O curve 3
						direction=1;
						start_angle=90;
						ellipse_center=new Point(start_point.x,end_point.y);
					}				
				}				
			}
						
			var lines:Vector.<VectorLine>=new Vector.<VectorLine>();
			var prev:Point=start_point;
			var next:Point;
			var next_x:Number;
			var next_y:Number;
			var cur_angle:Number=start_angle;
			
			var l:VectorLine;
			for(var i:uint=0;i<increments;i++){
				next_x=ellipse_center.x+Math.cos( cur_angle*MathUtil.PI_180)*h_radius;
				next_y=ellipse_center.y+Math.sin( cur_angle*MathUtil.PI_180)*v_radius;
				next=new Point(Math.floor(next_x),Math.floor(next_y));
				//FlexSimpleTraceBox.trace(next);
				l=new VectorLine(i,prev,next,0);
				l.type=VectorLine.DIAGONAL;
				lines[i]=l;
				prev=next;
				cur_angle+=(direction*angle_increment)
			}
			if(Point.distance(prev,end_point)>this._curve_accuracy/2){
				l=new VectorLine(0,prev,end_point,0)
				l.type=VectorLine.TEST;
				lines.push(l);
			}else{
				VectorLine(lines[lines.length-1]).end_point=end_point;
			}
			//FlexSimpleTraceBox.trace("curve lines.length:"+lines.length);
			return lines;
		}

		public function getPointsVector():Vector.<Point>{
			var p:Vector.<Point>=new Vector.<Point>();
			FlexSimpleTraceBox.trace("getPointsVector() _lines.length : "+_lines.length);
			if(_lines.length){
				for(var i:uint=0;i<_lines.length;i++){
					p[i]=VectorLine(_lines[i]).start_point;
				}
			}
			p[i]=VectorLine(_lines[i-1]).end_point;
			//FlexSimpleTraceBox.trace("\n\n**OPTIMIZED POINTS : \n"+p);
			//might still need to add the first as last to close the shape...
			return p;
		}


		
	}
}