package missions;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import ui.Styles;
import ui.TF;

/**
 * ...
 * @author damrem
 */
class DataLine extends Sprite
{
	var valueTf:TF;

	/**
	 * 
	 * @param	label
	 * @param	value
	 * @param	Width
	 * @param	fontSize
	 */
	public function new(label:String, value:String, Width:Float, format:TextFormat, heightLine:Float=240) 
	{
		super();
		
		var labelTf:TF = new TF(label, format);
		labelTf.height = heightLine;
		
		valueTf = new TF(value, format/*, TextFieldAutoSize.RIGHT*/);
		valueTf.height = heightLine;
		valueTf.x = Width - valueTf.width;
		
		addChild(labelTf);
		addChild(valueTf);
	}
	
	public function setValue(value:String)
	{
		valueTf.text = value;
	}
	
}
