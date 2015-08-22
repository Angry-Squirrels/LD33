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
	
	public static var WHITE24:TextFormat;
	public static var WHITE16:TextFormat;
	public static var WHITE12:TextFormat;
	
	public function new() {
		BLACK24 = new TextFormat(Assets.getFont("fonts/PressStart2P-Regular.ttf").fontName, 24, 0x000000);
		BLACK16 = new TextFormat(Assets.getFont("fonts/PressStart2P-Regular.ttf").fontName, 16, 0x000000);
		BLACK12 = new TextFormat(Assets.getFont("fonts/PressStart2P-Regular.ttf").fontName, 12, 0x000000);
		
		WHITE24 = new TextFormat(Assets.getFont("fonts/PressStart2P-Regular.ttf").fontName, 24, 0xffffff);
		WHITE16 = new TextFormat(Assets.getFont("fonts/PressStart2P-Regular.ttf").fontName, 16, 0xffffff);
		WHITE12 = new TextFormat(Assets.getFont("fonts/PressStart2P-Regular.ttf").fontName, 12, 0xffffff);
	}
}