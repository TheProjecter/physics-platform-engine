package com.vettigheid.engine.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import flash.geom.Point;

	public class ItemValueObject extends AbstractValueObject implements IValueObject
	{
		public function ItemValueObject(name:String, position:Point)
		{
			super(name, position);
		}
	}
}