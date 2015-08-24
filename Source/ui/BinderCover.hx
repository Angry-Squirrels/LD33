package ui;
import openfl.Assets;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.ColorTransform;
import openfl.text.TextFieldAutoSize;

/**
 * ...
 * @author Thomas BAUDON
 */
class BinderCover extends Sprite
{
	
	var title : String;
	var binder : Binder;
	
	var mainShape : Shape;
	var etiquette : Sprite;
	var etiquetteTF : TF;

	public function new(_binder : Binder, _title : String = "test") 
	{
		title = _title;
		binder = _binder;
		mainShape = new Shape(); 
		addChild(mainShape);
		mainShape.transform.colorTransform = new ColorTransform(1 - Math.random()*0.7, 1 - Math.random()*0.7, 1 - Math.random()*0.7);
		
		etiquette = new Sprite();
		etiquette.graphics.lineStyle(2, 0x6666ff);
		etiquette.graphics.beginFill(0xdedede);
		etiquette.graphics.drawRoundRect(0, 0, 250, 100, 20, 20);
		etiquette.graphics.moveTo(20, 65);
		etiquette.graphics.lineTo(230, 65);
		etiquette.graphics.endFill();
		etiquette.graphics.drawRoundRect(10, 10, 230, 80, 20, 20);
		
		addChild(etiquette);
		etiquetteTF = new TF(title, Styles.BLACK24, TextFieldAutoSize.LEFT);
		etiquette.addChild(etiquetteTF);
		etiquetteTF.x = (etiquette.width - etiquetteTF.width) / 2;
		etiquetteTF.y = (etiquette.height - etiquetteTF.height) / 2;
		super();
	}
	
	public function draw() {
		mainShape.graphics.clear();
		mainShape.graphics.beginBitmapFill(Assets.getBitmapData("images/paper.jpg"));
		mainShape.graphics.drawRect(0, 0, binder.width, binder.height);
		
		etiquette.x = (width - etiquette.width) / 2;
		etiquette.y = (height - etiquette.height) / 2;
		
		x = -width / 2; 
		y = -height / 2; 
	}
	
	
}