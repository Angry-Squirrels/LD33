package ui;

import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class PostIt extends AbstractPaperObject
{

	public function new(Width:Float=256, Height:Float=256, hMargin:Float=16, vMargin:Float=16) 
	{
		super(Width, Height, hMargin, vMargin);
		
		graphics.beginFill(0xffffa0);
		draw();
		graphics.endFill();
		
	}
	
}