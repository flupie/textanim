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
	* Events thats TextAnim instances dispatches.
	*/
	
	public class TextAnimEvent 
	{
		/**
		* Dispatched when TextAnim start to dispatche blocks.
		* <p>Example:</p>
		* <pre><code>
		* import flupie.textanim.TextAnim;
		*	
		* var myTextAnim:TextAnim = TextAnim.create(myTextField, {effect:myEffect});
		* myTextAnim.addEventListener(TextAnimEvent.START, startHandler);
		* myTextAnim.start();
		*	
		* function myEffect(block:TextAnimBlock):void {
		* 	block.scaleY = 2;
		* }
		*	
		* function startHandler(e:Event):void {
		* 	trace("START!");
		* }
		* </code></pre>
		*	
		* @eventType flupie.textanim.TextAnimEvent.START
		*/	
		public static const START:String = "start";

		/**
		* Dispatched when the dipatch blocks is on progress each blocks.
		* <p>Example:</p>
		*	
		* <pre><code>
		* import flupie.textanim.TextAnim;
		*	
		* var myTextAnim:TextAnim = new TextAnim(myTextField);
		* myTextAnim.effects = myEffect;
		* myTextAnim.addEventListener(TextAnimEvent.PROGRESS, progressHandler);
		* myTextAnim.start();
		*	
		* function myEffect(block:TextAnimBlock):void {
		* 	block.scaleY = 2;
		* }
		*	
		* function progressHandler(e:Event):void {
		* 	trace("PROGRESS");
		* } </code></pre>
		*	
		* @eventType flupie.textanim.TextAnimEvent.PROGRESS
		*/
		public static const PROGRESS:String = "progress";
		
		/**
		* Dispatched when dispatche blocks was completed.
		* <p>Example:</p>
		* <pre><code>
		* import flupie.textanim.TextAnim;
		*	
		* var myTextAnim:TextAnim = new TextAnim(myTextField);
		* myTextAnim.effects = myEffect;
		* myTextAnim.addEventListener(TextAnimEvent.COMPLETE, completeHandler);
		* myTextAnim.start();
		*	
		* function myEffect(block:TextAnimBlock):void {
		* 	block.scaleY = 2;
		* }
		*	
		* function completeHandler(e:Event):void {
		* 	trace("COMPLETE");
		* } </code></pre>
		*	
		* @eventType flupie.textanim.TextAnimEvent.COMPLETE
		*/
		public static const COMPLETE:String = "complete";

	}
}
