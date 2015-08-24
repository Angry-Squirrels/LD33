package ui;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.geom.ColorTransform;

/**
 * ...
 * @author damrem
 */
class Tab extends PaperObject
{
	var title:String;
	public var label:Sprite;

	public function new(title:String, Width:Float=304, Height:Float=344) 
	{
		super(Width, Height, 0, 0);
		this.title = title;
		
		
		label = new Sprite();
		label.buttonMode = true;
		
		var tf = new TF(title, Styles.BLACK12);
		tf.x = 16;
		tf.y = 4;
		
		var titleBg = new Shape();
		titleBg.graphics.beginFill(0xffff00);
		titleBg.graphics.drawRoundRect(0, 0, tf.width + 32, 32, 4);
		titleBg.graphics.endFill();
		
		var paperData = Assets.getBitmapData("images/paper.jpg");
		var bmpdt = new BitmapData(paperData.width, paperData.height,false);
		bmpdt.draw(paperData, null, new ColorTransform(1, 0.75, 0.5));
		bg.graphics.beginBitmapFill(bmpdt);
		//bg.alpha = 0.5;
		bg.height -= 32;
		bg.y = 32;
		drawBg();
		bg.graphics.endFill();
		
		label.addChild(titleBg);
		label.addChild(tf);
		addChild(label);
	}
	
	public function activate() {
		alpha = 1;
		//mouseChildren = true;
	}
	
	public function disactivate() {
		alpha = 0.5;
		//mouseChildren = false;
	}
	
	override public function toString():String
	{
		return "[Tab " + title+"]";
	}
	
}