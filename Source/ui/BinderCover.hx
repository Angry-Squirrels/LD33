package ui;
import openfl.display.Sprite;
import openfl.events.Event;

/**
 * ...
 * @author Thomas BAUDON
 */
class BinderCover extends Sprite
{
	
	var title : String;
	var binder : Binder;

	public function new(_binder : Binder, _title : String = "test") 
	{
		title = _title;
		binder = _binder;
		super();
	}
	
	public function draw() {
		graphics.clear();
		graphics.beginFill(0xff2244);
		graphics.drawRect(0, 0, binder.width, binder.height);
		
		x = -width / 2; 
		y = -height / 2; 
	}
	
	
}