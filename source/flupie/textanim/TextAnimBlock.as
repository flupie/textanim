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
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	* 	TextAnimBlock is the part of TextAnim that contains a text slice. 
	*	Is the target of <code>effects</code>.
	*	  
	*/
	public class TextAnimBlock extends Sprite
	{
		/**
		* 	The instance of TextAnim that the block belongs.
		*/		
		public var textAnim:TextAnim;
		
		/**
		* 	The textField containing the slice of original text.
		*/
		public var textField:TextField;
		
		/**
		* 	The TextFormat of the original text.
		*/
		public var textFormat:TextFormat;
		
		/**
		* 	Index works like a ID block in the TextAnim instance. Each block has a index, starting from 0. 
		* 	It serves as a reference for actions, delays and anything else.
		*/		
		public var index:int;
		
		/**
		* 	The original x position of the block. 
		*	<p>This value is generated after all blocks are created, and keeps the horizontal correct 
		*	position of the block in TextAnim.</p>
		*	<code>
		*	function myEffect(block:TextAnimBlock):void {
		*		block.x = block.posX - 100; //Put the block 100px left of correct position.
		*		Tweener.addTween(block, {x:block.posX, time:.5}) //Slide the block to correct position.
		*	}
		*	</code>
		*	
		*	@default 0;
		*/		
		public var posX:Number = 0;
		
		/**
		* 	The original y position of the block. 
		*	<p>This value is generated after all blocks are created, and keeps the vertical correct 
		*	position of the block in TextAnim.</p>
		*	<code>
		*	function myEffect(block:TextAnimBlock):void {
		*		block.y = block.posY + 100; //Put the block 100px below of correct position.
		*		Tweener.addTween(block, {y:block.posY, time:.5}) //Slide the block to correct position.
		*	}
		*	</code>
		*	
		*	@default 0;
		*/
		public var posY:Number = 0;
		
		/**
		* The empty <code>Object</code> to putting custom variables each blocks.
		* 
		*/
		public var vars:Object = {};
		
		/**
		* 	The container used for patterns, bitmaps, etc.
		*/
		public var texture:Sprite;
		
		/**
		* 	Reference to the next block. 
		*/
		public var nextBlock:TextAnimBlock;
		
		
		/**
		* 	Constructor. Created basically by a TextAnim instance.
		*	
		*	@param textAnim The TextAnim instance who contains this block.
		*	@param index The index of the block in TextAnim instance list.
		*/
		public function TextAnimBlock(textAnim:TextAnim, index:int)
		{
			texture = new Sprite();
			addChild(texture);
			
			this.textAnim = textAnim;
			this.index = index;
			
			textField = new TextField();

			textField.selectable = false;
			textField.embedFonts = true;
			textField.autoSize = TextFieldAutoSize.LEFT;
			
			addChild(textField);
			
			textField.antiAliasType = textAnim.source.antiAliasType;
			textField.sharpness = textAnim.source.sharpness;
			textField.thickness = textAnim.source.thickness;
			textField.filters = textAnim.source.filters;
			
			textFormat = textAnim.source.getTextFormat();
			textField.setTextFormat(textFormat);
		}
		
		public function set text(val:String):void
		{
			textField.htmlText = val;
			textField.setTextFormat(textFormat);
		}
		/**
		*	Sets the text of this block.
		*/
		public function get text():String { return textField.text; }
		
		
		/**
		* 	Clear references.
		*/
		public function dispose():void
		{
			if (contains(textField)) removeChild(textField);
			textField = null;
			textFormat = null;
			clearTexture();
			if (contains(texture)) removeChild(texture);
			texture = null;
			nextBlock = null;
		}

		/**
		* 	Sets the registration point of block;
		*	
		* 	@param px The horizontal registration.
		* 	@param py The vertical registration.
		*	
		*	@see TextAnimAnchor	
		*/
		public function updateRegistration(px:Number, py:Number):void
		{
			textField.x = px;
			textField.y = py;
			texture.x = textField.x;
			texture.y = textField.y;
			x = posX = posX - textField.x;
			y = posY = posY - textField.y;
		}
		
		/**
		* 	Clear the texture sprite that can contains any display objects, used in patterns, gradientColors, etc. 
		*/
		public function clearTexture():void
		{
			for (var i:int = 0; i < texture.numChildren ; i++) {
				var c:* = texture.getChildAt(i);
				texture.removeChild(c);
				c = null;
				i--;
			}
			texture.mask = null;
			if (textField != null) addChild(textField);
		}
		
	}
}