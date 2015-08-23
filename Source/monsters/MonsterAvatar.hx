package monsters;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.PixelSnapping;
import openfl.display.Sprite;
import ui.RectShape;

/**
 * ...
 * @author damrem
 */
class MonsterAvatar extends Sprite
{
	public var monster:Monster;
	public function new(monster:Monster, size:Float) 
	{
		super();
		this.monster = monster;
		
		//useHandCursor = true;
		buttonMode = true;
		
		var pic = new Bitmap(monster.picture);
		pic.width = pic.height = size;
		addChild(pic);
		
		var clicker = new RectShape(size, size);
		clicker.alpha = 0.5;
		addChild(clicker);
		
		//width = height = size;
		
	}
	
}