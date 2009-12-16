package com.vettigheid.engine.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import com.vettigheid.physics.objects.PlayerPhysicsObject;
	
	import flash.geom.Point;

	public class PlayerValueObject extends AbstractValueObject implements IValueObject
	{
		public function PlayerValueObject(position:Point)
		{
			super(position);
		}
	}
}