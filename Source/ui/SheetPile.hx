package ui;

import missions.MissionSheet;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class SheetPile extends Sprite
{
	var sheets:Array<PaperSheet>;
	var currentSheetIndex:Int=0;

	public function new() 
	{
		super();
		empty();
		
	}
	public function addSheet(sheet:PaperSheet) {
		trace("addsheet");
		if (sheets.length > 0) 
		{
			sheet.visible = false;
		}
		sheets.push(sheet);
		addChild(sheet);
	}
	
	public function next() {
		if (currentSheetIndex < sheets.length - 1) {
			sheets[currentSheetIndex].visible = false;
			currentSheetIndex++;
			sheets[currentSheetIndex].visible = true;
			
		}
	}
	
	public function prev() {
		if (currentSheetIndex >0) {
			sheets[currentSheetIndex].visible = false;
			currentSheetIndex--;
			sheets[currentSheetIndex].visible = true;
			
		}
	}
	
	public function empty() 
	{
		trace("empty");
		while (numChildren > 0) {
			removeChildAt(0);
		}
		sheets = new Array<PaperSheet>();
	}
}