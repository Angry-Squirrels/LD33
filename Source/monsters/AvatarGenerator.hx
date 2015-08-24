package monsters;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.geom.ColorTransform;

/**
 * ...
 * @author Thomas BAUDON
 */
class AvatarGenerator
{
	
	static var skull : Array<BitmapData>;
	static var eyes : Array<BitmapData>;
	static var mouth : Array<BitmapData>;
	static var hat : Array<BitmapData>;
	
	static var result : BitmapData;

	static public function getAvatar() : BitmapData {
		
		initFeatures();
		
		var bitmapData : BitmapData = new BitmapData(64, 64, false, Std.random(0x888889) + 0x777777);
		result = bitmapData;
		
		addSkull();
		
		return result;
	}
	
	static function initFeatures() {
		eyes = new Array<BitmapData>();
		
		mouth = new Array<BitmapData>();
		
		skull = new Array<BitmapData>();
		for (i in 0 ... 3) {
			var n = new BitmapData(64, 64, true);
			var s : Shape = new Shape();
			s.graphics.beginFill(0x888888);
			s.graphics.lineStyle(2, 0);
			if(i == 0)
				s.graphics.drawRoundRect(10, 20, 44, 44, 10, 10);
			if (i == 1)
				s.graphics.drawRect(10, 20, 44, 44);
			if (i == 2)
				s.graphics.drawCircle(32, 44, 22);
			s.graphics.endFill();
			n.draw(s);	
			skull.push(n);
		}
		
		hat = new Array<BitmapData>();
		
		
	}
	
	static function addSkull() {
		result.draw(skull[Std.random(skull.length)], null, new ColorTransform(Math.random() * 2, Math.random() * 2, Math.random() * 2), null, null, true);
	}
	
}