package ui;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class AbstractPaperObject extends Sprite
{
	var h:Float;
	var w:Float;
	var hMargin:Float;
	var vMargin:Float;

	public var bg:Sprite;
	
	public function new(Width:Float, Height:Float, hMargin:Float, vMargin:Float) 
	{
		super();
		this.vMargin = vMargin;
		this.hMargin = hMargin;
		bg = new Sprite();
		w = Width;
		h = Height;
	}
	public function draw() 
	{
		bg.graphics.clear();
		bg.graphics.drawRect(0, 0, w, h);
	}
	
}