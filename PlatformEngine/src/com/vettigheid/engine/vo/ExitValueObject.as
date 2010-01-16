package com.vettigheid.engine.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import flash.geom.Point;

	public class ExitValueObject extends AbstractValueObject implements IValueObject
	{
		public function ExitValueObject(name:String, position:Point)
		{
			super(name, position);
		}
	}
}