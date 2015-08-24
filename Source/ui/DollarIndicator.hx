package ui;

import openfl.display.Sprite;

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
		
		tf = new TF("$" + GameManager.getInstance().gold, Styles.WHITE16);
		addChild(tf);
		GameManager.getInstance().goldChanged.add(update);
		
	}
	
	function update(g:Int) {
		tf.text=("$" + g);
	}
	
}