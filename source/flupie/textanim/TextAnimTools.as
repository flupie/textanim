/*
	The MIT License

	Copyright (c) 2009 Guilherme Almeida and Mauro de Tarso

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
	
	http://code.google.com/p/textanim/
	http://flupie.net/blog/
*/       

package flupie.textanim
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	/**
	 *  Extra tools for special treatment of TextAnim instance. Can convert the blocks to bitmap, apply patterns, etc.
	 */
	public class TextAnimTools
	{
		/**
		* 	Convert blocks to Bitmap, instead original textField vector.
		*
		* 	@param textAnim Instance of TextAnim.
		* 	@param smooth Allow smooth bitmap.
		* 
		* 	@see #toVector
		*/
		public static function toBitmap(textAnim:TextAnim, smooth:Boolean = false):void
		{	
			textAnim.forEachBlocks(function (block:TextAnimBlock):void {
				block.clearTexture();
				
				var bounds:Rectangle = getColorBounds(block);
				var bmpData:BitmapData;
				
				if (bounds.width > 0) {
					bmpData = new BitmapData(bounds.width, bounds.height, true, 0x00000000);
					var mtx:Matrix = new Matrix(1, 0, 0, 1, -bounds.x, -bounds.y);
					bmpData.draw(block.textField, mtx);
				}
				
				
				
				var bmp:Bitmap = new Bitmap(bmpData, PixelSnapping.AUTO, smooth);
				block.texture.addChild(bmp);
				
				bmp.x = bounds.x;
				bmp.y = bounds.y;
				
				if (block.contains(block.textField)) block.removeChild(block.textField);
				
			});
			
			textAnim.onBlocksCreated = function():void {
				toBitmap(textAnim, smooth);
			};
		}
		
		
		/**
		* 	If the textAnim instance was converted to bitmap, <code>toVector</code> can reverse it.
		*
		* 	@param textAnim Instance of TextAnim.
		*	
		* 	@see #toBitmap
		*/
		public static function toVector(textAnim:TextAnim):void
		{
			textAnim.onBlocksCreated = null;
			textAnim.forEachBlocks(function (block:TextAnimBlock):void {
				block.clearTexture();
				block.addChild(block.textField);
			});
		}
		
		
		/**
		* 	Shows the registration reference of each block in a TextAnim instance.
		*
		* 	@param textAnim Instance of TextAnim.
		*	
		* 	@see TextAnimAnchor
		*/
		public static function showAnchors(textAnim:TextAnim):void
		{
			textAnim.forEachBlocks(function (block:TextAnimBlock):void {
				if (!block.getChildByName("regRef")) {
					var regRef:Shape = new Shape();
					regRef.name = "regRef";
					regRef.graphics.beginFill(0xFF0000);
					regRef.graphics.drawRect(0, 0, 2, 2);
					regRef.graphics.endFill();
					regRef.x = -1;
					regRef.y = -1;
					regRef.blendMode = "invert";
					block.addChild(regRef);
				}
			});
			textAnim.onBlocksCreated = function():void {
				showAnchors(textAnim);
			};
		}
		
		
		/**
		* 	Takes a display object to draw a texture in each TextAnim block.
		*
		* 	@param textAnim Instance of TextAnim.
		* 	@param img The source of texture bitmap.
		* 	@param stretch To extends the texture to fill up each block's area, without repetition.
		*
		*/
		public static function setPattern(textAnim:TextAnim, img:*, stretch:Boolean = false):void
		{
			textAnim.forEachBlocks(function (block:TextAnimBlock):void {
				
				var bounds:Rectangle = getColorBounds(block);
				var pattern:BitmapData;
				
				block.clearTexture();
				
				if (stretch) {
					pattern = new BitmapData(bounds.width, bounds.height, true, 0xffffff);
					var scX:Number = img.scaleX;
					var scY:Number = img.scaleY;
					img.width = bounds.width;
					img.height = bounds.height;
					var mtx:Matrix = new Matrix(img.scaleX, 0, 0, img.scaleY, 0, 0);
					pattern.draw(img, mtx);
					img.width = scX;
					img.height = scY;
				} else {
					pattern = new BitmapData(img.width, img.height, true, 0xffffff);
					pattern.draw(img);
				}
				
				var shape:Shape = new Shape();
				shape.graphics.beginBitmapFill(pattern);
				shape.graphics.drawRect(bounds.x-1, bounds.y-1, bounds.width+2, bounds.height+2);
				shape.graphics.endFill();
				block.texture.mask = block.textField;
				block.texture.addChild(shape);
			});
			
			textAnim.onBlocksCreated = function():void {
				setPattern(textAnim, img, stretch);
			};
		}
		
		
		/**
		* 	A linear gradient as a color of the text.
		*
		* 	@param textAnim Instance of TextAnim.
		* 	@param colors List of colors of the gradient.
		* 	@param angle The direction of the gradient (in degrees).
		* 	@param alphas The alpha of each color.
		* 	@param ratios The ratio of each color.
		*/
		public static function setGradientLinear(textAnim:TextAnim, colors:Array, angle:Number = 0, alphas:Array = null, ratios:Array = null):void
		{
			textAnim.forEachBlocks(function (block:TextAnimBlock):void {
				var bounds:Rectangle = getColorBounds(block);
				
				block.clearTexture();
				var shape:Shape = new Shape();
				var mt:Matrix = new Matrix();
				mt.createGradientBox(bounds.width, bounds.height, angle*Math.PI/360);
				shape.graphics.beginGradientFill("linear", colors, alphas != null ? alphas : [1, 1], ratios != null ? ratios : [0, 255], mt);
				shape.graphics.drawRect(bounds.x-1, bounds.y-1, bounds.width+2, bounds.height+2);
				shape.graphics.endFill();
				
				block.texture.addChild(shape);
				block.addChild(block.textField);
				block.texture.mask = block.textField;
			});
			
			textAnim.onBlocksCreated = function():void {
				setGradientLinear(textAnim, colors, angle, alphas, ratios);
			};
		}
		
		
		/**
		* Get color bounds of a TextAnimBlock instance.
		*
		* @param block The block measured.
		* @return Rectangle color bounds of a block.
		*/
		public static function getColorBounds(block:TextAnimBlock):Rectangle
		{
			var bmpData:BitmapData = new BitmapData(block.textField.width * 4, block.textField.height * 4, true, 0x00000000);
			var masked:Boolean = block.texture.mask != null ? true : false;
			var visible:Boolean = block.textField.visible;
			block.texture.mask = null;
			block.textField.visible = true;
			bmpData.draw(block.textField);
			var bounds:Rectangle = bmpData.getColorBoundsRect(0xFF000000, 0x00000000, false);
			bmpData.dispose();
			if (bounds == null) bounds = new Rectangle(0, 0, 0, 0);
			if (masked) block.texture.mask = block.textField;
			block.textField.visible = visible;
			return bounds;
		}
		
		
		/**
		* 	Use only when you not sure if TextAnim instance is working rightly.
		*
		* 	@param textAnim Instance of TextAnim.
		*/
		public static function debug(textAnim:TextAnim):void
		{
			if (textAnim.parent != null) textAnim.parent.addChild(textAnim.source);
			textAnim.source.alpha = .3;
			textAnim.source.border = true;
			textAnim.source.borderColor = 0x000000;
		}

	}
}