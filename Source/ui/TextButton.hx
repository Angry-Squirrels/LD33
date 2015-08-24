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
		
		var gray = new RectShape(startTf.width + 24, 36, 0xaaaaaa);
		upState.addChild(gray);
		var blue = new RectShape(startTf.width + 16, 28, 0x0080ff);
		blue.x = blue.y = 4;
		upState.addChild(blue);
		startTf.x = (upState.width - startTf.width) / 2;
		startTf.y = (upState.height - startTf.height) / 2;
		upState.addChild(startTf);
		
		addChild(upState);
		
		super();
		enable();
	}
	
	public function enable() {
		mouseEnabled = buttonMode = true;
		alpha = 1;
	}
	
	public function disable()
	{
		mouseEnabled = buttonMode = false;
		alpha = 0.5;
	}
	
}