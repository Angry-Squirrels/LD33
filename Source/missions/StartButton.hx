package missions;

import openfl.display.DisplayObject;
import openfl.display.SimpleButton;
import openfl.display.Sprite;
import ui.RectShape;
import ui.Styles;
import ui.TF;

/**
 * ...
 * @author damrem
 */
class StartButton extends Sprite
{

	public function new() 
	{
		
		var upState = new Sprite();
		upState.addChild(new RectShape(240, 32, 0x0080ff, 8, 0xaaaaaa));
		var startTf = new TF("Start mission", Styles.WHITE16);
		startTf.x = (upState.width - startTf.width) / 2;
		startTf.y = (upState.height - startTf.height) / 4;
		upState.addChild(startTf);
		
		addChild(upState);
		
		super();
		
	}
	
}