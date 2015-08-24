package monsters;
import openfl.Assets;
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
	static private var colorableMouths:Array<UInt>;

	static public function getAvatar() : BitmapData {
		
		initFeatures();
		
		var bitmapData : BitmapData = new BitmapData(64, 64, false, Std.random(0x888889) + 0x777777);
		result = bitmapData;
		
		addSkull();
		addMouth();
		addEyes();
		addHat();
		
		return result;
	}
	
	static function initFeatures() {
		
		eyes = new Array<BitmapData>();
		for (i in 0...9)
		{
			eyes.push(Assets.getBitmapData("images/eyes" + i+".png"));
		}
		
		mouth = new Array<BitmapData>();
		for (i in 0...4)
		{
			mouth.push(Assets.getBitmapData("images/mouth" + i+".png"));
		}
		colorableMouths = [0];
		
		skull = new Array<BitmapData>();
		for (i in 0...12)
		{
			skull.push(Assets.getBitmapData("images/head" + i+".png"));
		}
		
		/*for (i in 0 ... 3) {
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
		*/
		
		hat = new Array<BitmapData>();
		for (i in 0...3)
		{
			hat.push(Assets.getBitmapData("images/hat" + i+".png"));
		}
		
		
	}
	
	static function addSkull() {
		var ct = new ColorTransform();
		ct.redMultiplier = Math.random() * 2;
		ct.greenMultiplier = Math.random() * 2;
		ct.blueMultiplier = Math.random() * 2;
		result.draw(skull[Std.int(Math.random() * skull.length)], null, ct);
		//result.draw(skull[Std.random(skull.length)], null, new ColorTransform(Math.random() * 2, Math.random() * 2, Math.random() * 2), null, null, true);
	}
	
	static function addMouth() {
		var ct = new ColorTransform();
		var i:UInt = Std.int(Math.random() * mouth.length);
		if (colorableMouths.indexOf(i) >= 0)
		{
			ct.redMultiplier = Math.random() * 2;
			ct.greenMultiplier = Math.random() * 2;
			ct.blueMultiplier = Math.random() * 2;
		}
		result.draw(mouth[i], null, ct);
		//result.draw(skull[Std.random(skull.length)], null, new ColorTransform(Math.random() * 2, Math.random() * 2, Math.random() * 2), null, null, true);
	}
	
	static function addEyes() {
		var ct = new ColorTransform();
		ct.redMultiplier = Math.random() * 2;
		ct.greenMultiplier = Math.random() * 2;
		ct.blueMultiplier = Math.random() * 2;
		result.draw(eyes[Std.int(Math.random() * eyes.length)], null, ct);
		//result.draw(skull[Std.random(skull.length)], null, new ColorTransform(Math.random() * 2, Math.random() * 2, Math.random() * 2), null, null, true);
	}
	
	static function addHat() {
		var ct = new ColorTransform();
		ct.redMultiplier = Math.random() * 2;
		ct.greenMultiplier = Math.random() * 2;
		ct.blueMultiplier = Math.random() * 2;
		result.draw(hat[Std.int(Math.random() * hat.length)], null, ct);
		//result.draw(skull[Std.random(skull.length)], null, new ColorTransform(Math.random() * 2, Math.random() * 2, Math.random() * 2), null, null, true);
	}
	
}