package ui;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.text.TextFieldAutoSize;

/**
 * ...
 * @author damrem
 */
class DollarIndicator extends Sprite
{
	var tf:ui.TF;

	public function new() 
	{
		super();
		
		var bg = new Bitmap(Assets.getBitmapData("images/dollar-indicator.png"));
		addChild(bg);
		tf = new TF("$" + GameManager.getInstance().gold, Styles.BLACK24);
		tf.x = 55;
		tf.y = 29;
		addChild(tf);
		GameManager.getInstance().goldChanged.add(update);
		
	}
	
	function update(g:Int) {
		tf.text=("$" + g);
	}
	
}