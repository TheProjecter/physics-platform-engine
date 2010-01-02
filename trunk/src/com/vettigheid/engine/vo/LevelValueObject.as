package com.vettigheid.engine.vo
{
	import com.adobe.cairngorm.vo.ValueObject;

	public class LevelValueObject implements ValueObject
	{
		private var _tiles:Array;
		
		public function LevelValueObject(tiles:Array)
		{
			_tiles = tiles;
		}
		
		public function get height():Number
		{
			return _tiles.length;
		}
		
		public function get tiles():Array
		{
			return _tiles
		}
		
		public function get width():Number
		{
			return _tiles[0].length;
		}
	}
}