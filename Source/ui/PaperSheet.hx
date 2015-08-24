package ui;

import openfl.Assets;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class PaperSheet extends PaperObject
{

	public function new(Width:Float=400, Height:Float=480) 
	{
		super(Width, Height, 16, 16);
		
		bg.graphics.beginBitmapFill(Assets.getBitmapData ("images/paper.jpg"));
		//bg.graphics.beginFill(0xff0000);
		drawBg();
		bg.graphics.endFill();
	}
	
	public function activate() {
		visible = true;
	}
	
	public function disactivate() {
		visible = false;
	}
	
}