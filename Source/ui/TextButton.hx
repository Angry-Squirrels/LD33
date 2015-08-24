package ui;

import openfl.display.DisplayObject;
import openfl.display.SimpleButton;
import openfl.display.Sprite;
import openfl.text.TextFormat;
import ui.RectShape;
import ui.Styles;
import ui.TF;

/**
 * ...
 * @author damrem
 */
class TextButton extends Sprite
{

	public function new(text:String) 
	{
		
		var upState = new Sprite();
		var startTf = new TF(text, Styles.WHITE16);
		upState.addChild(new RectShape(startTf.width+32, 32, 0x0080ff, 8, 0xaaaaaa));
		startTf.x = (upState.width - startTf.width) / 2;
		startTf.y = (upState.height - startTf.height) / 4;
		upState.addChild(startTf);
		
		addChild(upState);
		
		super();
		enable();
	}
	
	public function enable() {
		mouseEnabled = true;
		alpha = 1;
	}
	
	public function disable()
	{
		mouseEnabled = false;
		alpha = 0.5;
	}
	
}