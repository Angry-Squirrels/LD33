package ui;

import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class PostIt extends PaperObject
{

	public function new(Width:Float=256, Height:Float=256, hMargin:Float=16, vMargin:Float=16) 
	{
		super(Width, Height, hMargin, vMargin);
		
		bg.graphics.beginFill(0xffffa0);
		drawBg();
		bg.graphics.endFill();
		
	}
	
}