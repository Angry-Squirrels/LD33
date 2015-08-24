package monsters;
import openfl.display.BitmapData;

/**
 * ...
 * @author Thomas BAUDON
 */
class AvatarGenerator
{

	static public function getAvatar() : BitmapData {
		var bitmapData : BitmapData = new BitmapData(64, 64, false, Std.random(0x888889) + 0x777777);
		return bitmapData;
	}
	
}