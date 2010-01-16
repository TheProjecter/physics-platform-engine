package com.vettigheid.engine.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	import flash.geom.Point;

	public class ItemValueObject extends AbstractValueObject implements IValueObject
	{
		private var _type:String;
		
		public function ItemValueObject(name:String, position:Point, type:String)
		{
			super(name, position);
		}
		
		public function get type():String
		{
			return _type;
		}
	}
}