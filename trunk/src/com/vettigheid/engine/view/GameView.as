package com.vettigheid.engine.view
{
	import flash.geom.Point;
	
	public class GameView extends AbstractView
	{
		private var _gameWidth:Number;
		private var _gameHeight:Number;
		
		public function GameView()
		{
			_gameWidth = this.width;
			_gameHeight = this.height;
		}
		
		public function set gameHeight(value:Number):void
		{
			_gameHeight = value;
		}
		
		public function set gameWidth(value:Number):void
		{
			_gameWidth = value;
		}
		
		public function get position():Point
		{
			return new Point(this.x, this.y);
		}
		
		public function set position(value:Point):void
		{
			if(value.x < this.width / 2)
			{
				this.x = 0;	
			}
			else if(value.x > _gameWidth - this.width / 2)
			{
				this.x = this.width - _gameWidth;
			}
			else
			{
				this.x = this.width / 2 - value.x;
			}
			
			if(value.y < this.height / 2)
			{
				this.y = 0;
			}
			else if(value.y > _gameHeight - this.height / 2)
			{
				this.y = this.height - _gameHeight;
			}
			else
			{
				this.y = this.height / 2 - value.y;
			}
		}
	}
}