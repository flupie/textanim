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
	*	The way thats TextAnim will dispatch the effects.
	*	<p>
	*	It orients the animation of text. If you want a phrase animating from right to left, from edges to center characters,
	*	randomly, you must set the <code>mode</code> property of TextAnim with one of these options:</p>
	*	<br/>
	*	<ul>
	*	<li>TextAnimMode.FIRST_LAST - Begins with the first char and ends with last (left to right).</li>
	*	<li>TextAnimMode.LAST_FIRST - Begins with the last char and ends with first.</li>
	*	<li>TextAnimMode.EDGES_CENTER - Begins with the first and last, then evolues to center.</li>
	*	<li>TextAnimMode.CENTER_EDGES - Begins in the central chars and evolues to edges.</li>
	*	<li>TextAnimMode.RANDOM - Animate randomly.</li>
	*	</ul>
	*	
	*	Example:
	*	<code>
	*	myTextAnim.mode = TextAnimMode.EDGES_CENTER; //Dispatche blocks from borders of text to center.
	*	</code>
	*/
	public class TextAnimMode 
	{
		public static const FIRST_LAST:String = DispatchFlow.FIRST_LAST;
		public static const LAST_FIRST:String = DispatchFlow.LAST_FIRST;
		public static const EDGES_CENTER:String = DispatchFlow.EDGES_CENTER;
		public static const CENTER_EDGES:String = DispatchFlow.CENTER_EDGES;
		public static const RANDOM:String = DispatchFlow.RANDOM;
	}
}
