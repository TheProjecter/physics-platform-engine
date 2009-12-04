package com.vettigheid.engine.vo
{
	import com.adobe.cairngorm.vo.ValueObject;
	
	import flash.geom.Point;

	public class LevelValueObject implements ValueObject
	{
		private var _tiles:Array;
		
		public function LevelValueObject(tiles:Array)
		{
			_tiles = tiles;
		}
		
		public function get tiles():Array
		{
			return _tiles
		}
	}
}