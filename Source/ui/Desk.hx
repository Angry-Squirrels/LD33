package ui;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class Desk extends Sprite
{

	public function new() 
	{
		super();
		addChild(new Bitmap(Assets.getBitmapData("images/desk.jpg")));
		
	}
	
}