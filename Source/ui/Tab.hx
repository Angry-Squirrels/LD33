package ui;
import openfl.display.Shape;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class Tab extends PaperObject
{
	public var label:Sprite;

	public function new(title:String, Width:Float=384, Height:Float=464) 
	{
		super(Width, Height, 16, 16);
		
		label = new Sprite();
		
		var tf = new TF(title, Styles.BLACK16);
		tf.x = 16;
		tf.y = 4;
		
		var titleBg = new Shape();
		titleBg.graphics.beginFill(0xffff00);
		titleBg.graphics.drawRoundRect(0, 0, tf.width + 32, 32, 4);
		titleBg.graphics.endFill();
		
		bg.graphics.beginFill(0x00ff00);
		bg.alpha = 0.5;
		draw();
		bg.graphics.endFill();
		
		label.addChild(titleBg);
		label.addChild(tf);
		addChild(label);
	}
	
	
	
}