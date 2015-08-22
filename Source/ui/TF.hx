package ui;

import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;

/**
 * ...
 * @author damrem
 */
class TF extends TextField
{

	public function new(Text:String, format:TextFormat, ?autosize)
	{
		super();
		selectable = false;
		defaultTextFormat = format;
		autoSize = (autosize==null)?TextFieldAutoSize.LEFT:autosize;
		text = Text;
		
	}
	
}