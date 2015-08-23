package ui;
import openfl.display.Shape;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class Tab extends PaperObject
{
	var title:String;
	public var label:Sprite;

	public function new(title:String, Width:Float=384, Height:Float=464) 
	{
		super(Width, Height, 16, 16);
		this.title = title;
		
		label = new Sprite();
		
		var tf = new TF(title, Styles.BLACK16);
		tf.x = 16;
		tf.y = 4;
		
		var titleBg = new Shape();
		titleBg.graphics.beginFill(0xffff00);
		titleBg.graphics.drawRoundRect(0, 0, tf.width + 32, 32, 4);
		titleBg.graphics.endFill();
		
		bg.graphics.beginFill(0xff00ff);
		bg.alpha = 0.5;
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