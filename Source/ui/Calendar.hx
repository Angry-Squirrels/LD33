package ui;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.filters.GlowFilter;
import openfl.text.TextFieldAutoSize;

/**
 * ...
 * @author damrem
 */
class Calendar extends Sprite
{
	//var next:ui.TF;
	var gameManager:GameManager;
	var tf:ui.TF;
	var uigame : UIGame;

	public function new(_uigame : UIGame) 
	{
		super();
		
		uigame = _uigame;
		
		var block = new Bitmap(Assets.getBitmapData("images/calendar.png"));
		addChild(block);
		
		gameManager = GameManager.getInstance();
		
		var page = new Sprite();
		
		addChild(page);
		page.x = -60;
		page.y = -100;
		page.z = 500;
		page.rotationX = 50;
		
		
		
		tf = new TF(cast(gameManager.getDate()), Styles.CALENDAR_BIG, TextFieldAutoSize.CENTER);
		tf.scaleX = tf.scaleY = 1.5;
		
		//tf.rotationZ = 2.5;
		page.addChild(tf);
		
		
		//next = new TF("Next day", Styles.CALENDAR_SMALL);
		//page.addChild(next);
		
		buttonMode = true;
		
		addEventListener(MouseEvent.CLICK, nextDay);
		addEventListener(MouseEvent.MOUSE_OVER, drawHalo);
		addEventListener(MouseEvent.MOUSE_OUT, removeHalo);
	}
	
	private function removeHalo(e:MouseEvent):Void 
	{
		filters = [];
	}
	
	private function drawHalo(e:MouseEvent):Void 
	{
		filters = [new GlowFilter(0xffffff)];
	}
	
	private function nextDay(e:MouseEvent=null):Void 
	{
		uigame.dayTransition();
	}
	
	public function updateDate() {
		tf.text = cast gameManager.getDate();
	}
	
}