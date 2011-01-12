package com.mgrenier.fexel.display 
{
	import com.mgrenier.fexel.fexel;
	use namespace fexel;
	
	import com.mgrenier.utils.Disposable;
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	/**
	 * Entities container
	 */
	public class DisplayObjectContainer extends DisplayObject
	{
		protected var childs:Vector.<DisplayObject>;
		
		/**
		 * Constructor
		 */
		public function DisplayObjectContainer() 
		{
			super();
			
			this.childs = new Vector.<DisplayObject>();
		}
		
		/**
		 * Dispose World
		 */
		override public function dispose ():void
		{
			var c:DisplayObject;
			while (this.childs.length > 0)
			{
				c = this.childs.pop();
				c.dispose();
				c = null;
			}
			this.childs = null;
		}
		
		/**
		 * Render to buffer
		 */
		override fexel function render (buffer:BitmapData, transformation:Matrix):void
		{
			var i:int,
				n:int,
				matrix:Matrix = transformation.clone(),
				c:DisplayObject;
			matrix.transformPoint(this.transformationPoint.point);
			matrix.translate(this.x, this.y);
			matrix.scale(this.scaleX, this.scaleY);
			
			for (i = 0, n = this.childs.length; i < n; ++i)
			{
				c = this.childs[i];
				c.render(buffer, matrix);
			}
		}
		
		/**
		 * Get child
		 * 
		 * @return
		 */
		public function getChilds ():Vector.<DisplayObject>
		{
			return this.childs;
		}
		
		/**
		 * Add child
		 * 
		 * @param	e
		 * @return
		 */
		public function addChild (c:DisplayObject):DisplayObject
		{
			this.childs.push(c);
			return c;
		}
		
		/**
		 * Remove child
		 * 
		 * @param	e
		 * @return
		 */
		public function removeChild (c:DisplayObject):DisplayObject
		{
			return this.removeChildAt(this.childs.indexOf(c));
		}
		
		/**
		 * Remove child at index
		 * 
		 * @param	e
		 * @return
		 */
		public function removeChildAt (i:int):DisplayObject
		{
			var splice:Vector.<DisplayObject> = this.childs.splice(i, 1);
			return splice.length == 0 ? null : splice[0];
		}
		
		/**
		 * Remove childs
		 */
		public function removeAllChilds ():DisplayObjectContainer
		{
			//for (var n:int = this.childs.length - 1; n >= 0; n--)
			//	this.removeChild(this.childs[n]);
			this.childs = new Vector.<DisplayObject>();
			return this;
		}
		
		/**
		 * Change position of an existing entity
		 * 
		 * @param	e
		 * @param	index
		 * @return
		 */
		public function setChildIndex (c:DisplayObject, index:int):DisplayObjectContainer
		{
			this.childs.splice(index, 0, this.childs.splice(this.childs.indexOf(c), 1));
			return this;
		}
		
		/**
		 * Swap position of childs
		 * 
		 * @param	c1
		 * @param	c2
		 * @return
		 */
		public function swapChildren (c1:DisplayObject, c2:DisplayObject):DisplayObjectContainer
		{
			return this.swapChildrenAt(this.childs.indexOf(c1), this.childs.indexOf(c2));
		}
		
		/**
		 * Swap position
		 * 
		 * @param	i1
		 * @param	i2
		 * @return
		 */
		public function swapChildrenAt (i1:int, i2:int):DisplayObjectContainer
		{
			if (i1 < i2)
				this.childs.splice(i2 - 1, 0, this.childs.splice(i1, 1, this.childs.splice(i2, 1)));
			else
				this.childs.splice(i1 - 1, 0, this.childs.splice(i2, 1, this.childs.splice(i1, 1)));
			
			return this;
		}
		
	}
	
}