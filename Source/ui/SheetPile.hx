package ui;

import missions.sheets.AbstractMissionSheet;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

/**
 * ...
 * @author damrem
 */
class SheetPile extends Sprite
{
	var sheets:Array<PaperSheet>;
	var holder:Sprite;
	var currentSheetIndex:Int=0;
	var prevArrow:openfl.display.Sprite;
	var nextArrow:openfl.display.Sprite;

	public function new(Width:Float, Height:Float) 
	{
		super();
		holder = new Sprite();
		addChild(holder);
		
		var arrowBmp = Assets.getBitmapData("images/arrow.png");
		
		prevArrow = new Sprite();
		prevArrow.addChild(new Bitmap(arrowBmp));
		prevArrow.buttonMode = true;
		prevArrow.x = 48;
		prevArrow.y = Height - 16;
		prevArrow.rotation = 180;
		prevArrow.addEventListener(MouseEvent.CLICK, prev);
		addChild(prevArrow);
		
		nextArrow = new Sprite();
		nextArrow.addChild(new Bitmap(arrowBmp));
		nextArrow.buttonMode = true;
		nextArrow.x = Width-48;
		nextArrow.y = Height - 16 - nextArrow .height;
		nextArrow.addEventListener(MouseEvent.CLICK, next);
		addChild(nextArrow );
		
		empty();
		
	}
	public function addSheet(sheet:PaperSheet) {
		trace("addsheet");
		if (sheets.length > 0) 
		{
			sheet.visible = false;
		}
		sheets.push(sheet);
		holder.addChild(sheet);
		updateArrows();
	}
	
	public function next(evt:MouseEvent = null) {
		trace("next?");
		if (currentSheetIndex < sheets.length - 1) {
			trace("next!");
			sheets[currentSheetIndex].disactivate();
			currentSheetIndex++;
			sheets[currentSheetIndex].activate();
		}
		updateArrows();
	}
	
	public function prev(evt:MouseEvent = null) {
		trace("prev?");
		if (currentSheetIndex > 0) {
			trace("prev!");
			sheets[currentSheetIndex].disactivate();
			currentSheetIndex--;
			sheets[currentSheetIndex].activate();
			
		}
		updateArrows();
	}
	
	function updateArrows()
	{
		if(currentSheetIndex==sheets.length-1)
		{
			nextArrow.alpha = 0.25;
		}
		else
		{
			nextArrow.alpha = 1;
		}
		if(currentSheetIndex==0)
		{
			prevArrow.alpha = 0.25;
		}
		else
		{
			prevArrow.alpha = 1;
		}
	}
	
	public function empty() 
	{
		trace("empty");
		while (holder.numChildren > 0) {
			holder.removeChildAt(0);
		}
		sheets = new Array<PaperSheet>();
	}
	
	public function getCurrentSheet():PaperSheet
	{
		trace(sheets);
		trace(currentSheetIndex);
		return sheets[currentSheetIndex];
	}
}