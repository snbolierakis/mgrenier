package com.mgrenier.fexel.display
{
	import com.mgrenier.fexel.fexel;
	use namespace fexel;
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.ColorTransform;
	import flash.display.Sprite;
	
	/**
	 * TiledBitmap
	 * 
	 * @author Michael Grenier
	 */
	public class TiledBitmap extends Bitmap
	{
		public var bitmap:Bitmap;
		private var _matrix:Matrix;
		
		/**
		 * Constructor
		 */
		public function TiledBitmap(width:Number, height:Number, transparent:Boolean=true, smooth:Boolean=false)
		{
			super(width, height, transparent, smooth);
			this.bitmapData = new BitmapData(width, height, transparent, transparent ? 0x00000000 : 0xff000000);
			this._matrix = new Matrix();
		}
		
		/**
		 * Dispose
		 */
		override public function dispose ():void
		{
			if (this.bitmap)
			{
				this.bitmap.dispose();
				this.bitmap = null;
			}
			
			super.dispose();
		}
		
		/**
		 * Render to buffer
		 * 
		 * @param	buffer
		 * @param	transformation
		 * @param	color
		 * @param	rate
		 */
		override fexel function render (buffer:BitmapData, matrix:Matrix, color:ColorTransform, rate:int):void
		{
			if (!this.bitmap)
				return;
			
			var tiling:Sprite = Bitmap.sprite;
			tiling.graphics.clear();
			tiling.graphics.beginBitmapFill(this.bitmap.bitmapData, this._matrix, true, this.smooth);
			tiling.graphics.drawRect(0, 0, this.bitmapData.width, this.bitmapData.height);
			tiling.graphics.endFill();
			
			this.bitmapData.draw(tiling, this._matrix, null, null, null, this.smooth);
			
			super.render(buffer, matrix, color, rate);
		}
	}
}