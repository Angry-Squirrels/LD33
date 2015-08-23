package ui;

import openfl.display.Sprite;
import openfl.events.MouseEvent;

/**
 * ...
 * @author damrem
 */
class Calendar extends PaperObject
{
	var next:ui.TF;
	var gameManager:GameManager;
	var tf:ui.TF;

	public function new() 
	{
		super(256, 256, 32, 32);
		
		gameManager = GameManager.getInstance();
		
		bg.graphics.beginFill(0x808080);
		drawBg();
		bg.graphics.endFill();
		
		tf = new TF(cast(gameManager.getDate()), Styles.BLACK24);
		content.addChild(tf);
		
		
		next = new TF("Next day", Styles.BLACK12);
		content.addChild(next);
		
		buttonMode = true;
		
		addEventListener(MouseEvent.CLICK, nextDay);
	}
	
	private function nextDay(e:MouseEvent=null):Void 
	{
		gameManager.startNewDay();
		tf.text = cast(gameManager.getDate());
	}
	
}