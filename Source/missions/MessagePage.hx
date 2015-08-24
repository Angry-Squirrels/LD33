package missions;

import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.text.TextFieldAutoSize;
import ui.PaperSheet;
import ui.TextButton;
import ui.TF;

import ui.Styles;

/**
 * ...
 * @author Thomas BAUDON
 */
class MessagePage extends PaperSheet
{
	
	var binder : ReportBinder;

	public function new(_binder : ReportBinder) 
	{
		
		super();
		
		binder = _binder;
		
		var messages = GameManager.getInstance().messages;
		
		while (messages.length > 0 ) {
			var message = messages.shift();
			var txt = new TF(" * " + message, Styles.BLACK10, TextFieldAutoSize.LEFT);
			txt.wordWrap = true;
			txt.multiline = true;
			txt.width = contentWidth;
			content.addChild(txt);
			txt.y = currentY;
			currentY += txt.height + 5;
		}
		
		var button = new TextButton("Got it!");
		button.x = (content.width - button.width) / 2;
		button.y = currentY + 10;
		button.addEventListener(MouseEvent.CLICK, onClick);
		content.addChild(button);
		
	}
	
	private function onClick(e:MouseEvent):Void 
	{
		binder.removeMessagePage();
	}
	
}