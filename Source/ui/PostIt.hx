package ui;

import openfl.Assets;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.geom.ColorTransform;

/**
 * ...
 * @author damrem
 */
class PostIt extends PaperObject
{

	public function new(Width:Float=256, Height:Float=256, hMargin:Float=16, vMargin:Float=16) 
	{
		super(Width, Height, hMargin, vMargin);
		
		var paperData = Assets.getBitmapData("images/paper.jpg");
		var bmpdt = new BitmapData(paperData.width, paperData.height,false);
		bmpdt.draw(paperData, null, new ColorTransform(1.5, 1.5, 0.75));
		bg.graphics.beginBitmapFill(bmpdt);
		drawBg();
		bg.graphics.endFill();
		
	}
	
}