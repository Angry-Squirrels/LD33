package ui;
import openfl.Assets;
import openfl.text.TextFormat;

/**
 * ...
 * @author damrem
 */
class Styles
{
	
	public static var BLACK24:TextFormat;
	public static var BLACK16:TextFormat;
	public static var BLACK12:TextFormat;
	public static var BLACK10:TextFormat;
	
	public static var WHITE24:TextFormat;
	public static var WHITE16:TextFormat;
	public static var WHITE12:TextFormat;
	
	public static var CALENDAR_BIG:TextFormat;
	public static var CALENDAR_SMALL:TextFormat;
	
	public function new() {
		
		var ps2p = Assets.getFont("fonts/ps2p.ttf").fontName;
		
		BLACK24 = new TextFormat(ps2p, 20, 0x000000);
		BLACK16 = new TextFormat(ps2p, 15, 0x000000);
		BLACK12 = new TextFormat(ps2p, 10, 0x000000);
		BLACK10 = new TextFormat(ps2p, 10, 0x000000);
		
		WHITE24 = new TextFormat(ps2p, 20, 0xffffff);
		WHITE16 = new TextFormat(ps2p, 15, 0xffffff);
		WHITE12 = new TextFormat(ps2p, 10, 0xffffff);
		
		var impact = Assets.getFont("fonts/impact.ttf").fontName;
		CALENDAR_BIG = new TextFormat(impact, 48, 0xff0000);
		CALENDAR_SMALL = new TextFormat(impact, 12, 0xff0000);
	}
	
	
}