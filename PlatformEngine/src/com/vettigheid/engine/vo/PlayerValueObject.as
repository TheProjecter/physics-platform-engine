package com.vettigheid.engine.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	import flash.geom.Point;

	public class PlayerValueObject extends AbstractValueObject implements IValueObject
	{
		public function PlayerValueObject(position:Point)
		{
			super("Player", position);
		}
	}
}