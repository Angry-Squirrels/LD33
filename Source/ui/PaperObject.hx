package ui;
import openfl.Assets;
import openfl.display.DisplayObject;
import openfl.display.Shape;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class PaperObject extends Sprite
{
	var h:Float;
	var w:Float;
	var hMargin:Float;
	var vMargin:Float;
	var content:Sprite;
	var contentWidth:Float;
	var currentY:Float=0;

	public var bg:Shape;
	
	public function new(Width:Float, Height:Float, hMargin:Float, vMargin:Float) 
	{
		super();
		this.vMargin = vMargin;
		this.hMargin = hMargin;
		bg = new Shape();
		w = Width;
		h = Height;
		addChild(bg);
		
		contentWidth = Width - hMargin * 2;
		
		content = new Sprite();
		content.x = hMargin;
		content.y = vMargin;
		addChild(content);
	}
	public function drawBg() 
	{
		//bg.graphics.beginBitmapFill(Assets.getBitmapData("images/paper.jpg"));
		bg.graphics.drawRect(0, 0, w, h);
		//bg.graphics.endFill();
	}
	
	public function getW()
	{
		return w;
	}
	
	public function getH()
	{
		return h;
	}
	
	
	
}