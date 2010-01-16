package com.vettigheid.grid
{
	import com.vettigheid.editor.event.GridEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class Tile extends Sprite
	{
		public function Tile(x:Number, y:Number)
		{
			this.graphics.lineStyle(1, 0x000000);
			this.graphics.beginFill(0xffffff);
			this.graphics.drawRect(0, 0, 40, 40);
			this.graphics.endFill();
			
			this.x = x;
			this.y = y;
			
			this.addEventListener(MouseEvent.CLICK, handleMouseClick, false, 0, true);
		}
		
		private function handleMouseClick(e:MouseEvent):void
		{
			var gridEvent:GridEvent = new GridEvent(GridEvent.CLICK, this);
			gridEvent.dispatch();
		}
	}
}