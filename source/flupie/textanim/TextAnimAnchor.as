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
	* 	TextAnimAnchor configures the point of registration of each TextAnimBlock.
	*	<p>Use to change anchor properties. TOP and BOTTOM works with vertical orientation. LEFT and RIGHT
	*	works with horizontal. CENTER can set either.
	*	</p>
	*	<pre><code>
	*	import flupie.textanim.TextAnim;
	*	
	*	var myTextAnim:TextAnim = new TextAnim(myTextField);
	*	myTextAnim.effects = myEffect;
	*	myTextAnim.anchorY = TextAnimAnchor.TOP; //changes the vertical registration to TOP, and keeps horizontal registration.
	*	myTextAnim.start();
	*	
	*	function myEffect(block:TextAnimBlock):void {
	*		block.scaleY = 2;
	*	}
	*	</code></pre>
	*	
	*	<p>
	*	You can use <code>TextAnimTools.showAnchors(myTextAnim)</code> to visualize the anchor points.
	*	</p>
	*	 
	*/
	public class TextAnimAnchor 
	{
		public static const TOP:String = "T";
		public static const LEFT:String = "L";
		public static const RIGHT:String = "R";
		public static const BOTTOM:String = "B";
		public static const CENTER:String = "C";
	}
}
