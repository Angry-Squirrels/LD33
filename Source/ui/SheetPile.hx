package ui;

import missions.MissionSheet;
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

	public function new(Width:Float, Height:Float) 
	{
		super();
		holder = new Sprite();
		addChild(holder);
		
		var arrowBmp = Assets.getBitmapData("images/arrow.png");
		
		var prevArrow = new Sprite();
		prevArrow.addChild(new Bitmap(arrowBmp));
		prevArrow.buttonMode = true;
		prevArrow.x = 32;
		prevArrow.y = Height - 32;
		prevArrow.rotation = 180;
		prevArrow.addEventListener(MouseEvent.CLICK, prev);
		addChild(prevArrow);
		
		var nextArrow = new Sprite();
		nextArrow.addChild(new Bitmap(arrowBmp));
		nextArrow.buttonMode = true;
		nextArrow.x = Width-32;
		nextArrow.y = Height - 32 - nextArrow .height;
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
	}
	
	public function next(evt:MouseEvent = null) {
		trace("next?");
		if (currentSheetIndex < sheets.length - 1) {
			trace("next!");
			sheets[currentSheetIndex].visible = false;
			currentSheetIndex++;
			sheets[currentSheetIndex].visible = true;
			
		}
	}
	
	public function prev(evt:MouseEvent = null) {
		trace("prev?");
		if (currentSheetIndex > 0) {
			trace("prev!");
			sheets[currentSheetIndex].visible = false;
			currentSheetIndex--;
			sheets[currentSheetIndex].visible = true;
			
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
		return sheets[currentSheetIndex];
	}
}