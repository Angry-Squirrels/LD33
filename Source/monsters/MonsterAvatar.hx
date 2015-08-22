package monsters;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.PixelSnapping;

/**
 * ...
 * @author damrem
 */
class MonsterAvatar extends Bitmap
{

	public function new(bitmapData:BitmapData, size:Float) 
	{
		super(bitmapData);
		width = height = size;
		
	}
	
}