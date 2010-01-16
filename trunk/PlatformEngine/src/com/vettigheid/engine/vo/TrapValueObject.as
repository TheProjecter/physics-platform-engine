package com.vettigheid.engine.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import flash.geom.Point;

	public class TrapValueObject extends AbstractValueObject implements IValueObject
	{
		public function TrapValueObject(name:String, position:Point)
		{
			super(name, position);
		}
	}
}