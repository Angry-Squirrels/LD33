package missions;
import openfl.display.Shape;
import openfl.display.Sprite;
import ui.RectShape;

/**
 * ...
 * @author damrem
 */
class ProbabilityBar extends Sprite
{
	var indicator:Shape;

	public function new(Width:Float, Height:Float) 
	{
		super();
		
		var bg:RectShape = new RectShape(Width, Height, 0x000000);
		bg.alpha = 0.25;
		addChild(bg);
		
		indicator = new RectShape(0.1, Height);
		addChild(indicator);
		addChild(indicator);
		
		var border = new Shape();
		border.graphics.lineStyle(2, 0x000000, 0.25);
		border.graphics.drawRect(0, 0, Width, Height);
		addChild(border);
	}
	
	public function setPercentage(pc:Float) {
		indicator.width = pc * width;
	}
	
}