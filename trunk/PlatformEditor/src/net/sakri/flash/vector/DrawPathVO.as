package net.sakri.flash.vector{
	import __AS3__.vec.Vector;
	
	
	public class DrawPathVO{
		
		public var commands:Vector.<int>;
		public var data:Vector.<Number>;
		
		public function DrawPathVO(commands:Vector.<int>,data:Vector.<Number>){
			this.commands=commands;
			this.data=data;
		}

	}
}