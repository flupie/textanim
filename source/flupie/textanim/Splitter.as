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
	/**
	 * Separate blocks of text with the specified break
	 *	
	 *	@private
	 */	
	internal class Splitter
	{
		public static const CHARS:String = "chars";
		public static const WORDS:String = "words";
		public static const LINES:String = "lines";
		
		internal static function separeBlocks(block:TextAnim, split:String = CHARS):TextAnimBlock 
		{
			var firstBlock:TextAnimBlock;
			switch (split.toLowerCase()) {
				case CHARS :
					firstBlock = breakInLetters(block);
					break;
				case WORDS :
					firstBlock = breakInWords(block);
					break;
				case LINES :
					firstBlock = breakInLines(block);
					break;
				default : firstBlock = breakInLetters(block);
			}
			return firstBlock;
		}
		
		internal static function createBlock(anim:TextAnim, str:String, index:Number):TextAnimBlock 
		{
			var block:TextAnimBlock = new TextAnimBlock(anim, index);
			block.text = str;
			return block;
		}
		
		internal static function breakInLetters(anim:TextAnim):TextAnimBlock 
		{
			var txt:String = anim.source.text;
			var block:TextAnimBlock;
			var firstBlock:TextAnimBlock;
			
			for (var i:int = 0; i < txt.length; i++) {
				var str:String = txt.substr(i, 1);
				if(str != String.fromCharCode(13)) {
					if (stringTest(str)) {
						var newBlock:TextAnimBlock = createBlock(anim, str, i);	
						if (block != null) {
							block.nextBlock = newBlock;
						} else {
							firstBlock = newBlock;
						}
						block = newBlock;
					}
				}
			}
			
			return firstBlock;
		}
		
		internal static function breakInWords(anim:TextAnim):TextAnimBlock 
		{
			var temp:Array = [];
			var str:String = "";
			var firstIndex:Number=0;
			var txt:String = anim.source.text;
			var block:TextAnimBlock;
			var firstBlock:TextAnimBlock;
			var newBlock:TextAnimBlock;
			
			for (var i:int = 0; i < txt.length; i++) {
				var s:String = txt.substr(i, 1);
				
				if (s != " " && s != null && s != String.fromCharCode(13)) {
					if(str == "") firstIndex = i;
					str += s;
				} else if (s != null) {
					if (stringTest(str)) {
						newBlock = createBlock(anim, str, firstIndex);	
						if (block != null) {
							block.nextBlock = newBlock;
						} else {
							firstBlock = newBlock;
						}
						block = newBlock;
					}
					str = "";
				}
			}

			if (stringTest(str)) {
				newBlock = createBlock(anim, str, firstIndex);	
				if (block != null) {
					block.nextBlock = newBlock;
				} else {
					firstBlock = newBlock;
				}
				block = newBlock;
			}
			
			return firstBlock;
		}
		
		internal static function breakInLines(anim:TextAnim):TextAnimBlock
		{
			var temp:Array = [];
			var block:TextAnimBlock;
			var firstBlock:TextAnimBlock;
			
			for (var i:int = 0; i < anim.source.numLines; i++) {
					var str:String = anim.source.getLineText(i);
					if (str != "" && str.length > 0 && str != null) {
						if (stringTest(str)) {
							var newBlock:TextAnimBlock = createBlock(anim, str, anim.source.getLineOffset(i));	
							if (block != null) {
								block.nextBlock = newBlock;
							} else {
								firstBlock = newBlock;
							}
							block = newBlock;
						}
					}
			}
			return firstBlock;
		}
		
		internal static function stringTest(str:String):Boolean
		{
			if (str != "" && str != " " && str.length > 0) return true;
			
			return false;
		}
	}
}