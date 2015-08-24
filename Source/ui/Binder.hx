package ui;
import motion.Actuate;
import motion.easing.Quad;
import msignal.Signal.Signal1;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.filters.DropShadowFilter;
import openfl.filters.GlowFilter;
import openfl.geom.Matrix;
import openfl.geom.Matrix3D;
import openfl.geom.Point;
import openfl.geom.Vector3D;
import openfl.Lib;

/**
 * ...
 * @author damrem
 */
class Binder extends PaperObject
{
	
	var tabs:Array<Tab>;
	var currentTab:Tab;
	var lastTab:Tab;
	var cover : BinderCover;
	
	public var isOpened:Bool;
	public var isOpenedChanged:Signal1<Bool>;
	public var title : String;
	
	var pressed : Bool;
	var mouseDragPoint : Point;
	
	var dropShadow : DropShadowFilter;

	public function new(_title : String = "") 
	{
		super(280, 360, 16, 16);
		title = _title;
		isOpenedChanged = new Signal1<Bool>();
		tabs = new Array<Tab>();
		
		cover = new BinderCover(this, _title);
		addChild(cover);
		
		dropShadow = new DropShadowFilter(3);
		
		close();
		
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		
		drawBg();
		bg.x -= bg.width / 2;
		bg.y -= bg.height / 2;
	}
	
	function onMouseMove(e:MouseEvent):Void 
	{
		if (pressed && isOpened) {
		
			var nextX = e.stageX - mouseDragPoint.x;
			var nextY = e.stageY - mouseDragPoint.y;
			
			var diffX = nextX - x;
			var diffY = nextY - y;
			
			/*var mat = transform.matrix3D;
			
			var rotMat = new Matrix3D();
			rotMat.appendRotation(0.2, Vector3D.Z_AXIS, new Vector3D( -100, -100, 0));
			mat.append(rotMat);*/
			
			x += diffX;
			y += diffY;
		}
	}
	
	function onMouseUp(e:MouseEvent):Void 
	{
		pressed = false;
	}
	
	function onMouseDown(e:MouseEvent):Void 
	{
		pressed = true;
		
		var gx = e.stageX;
		var gy = e.stageY;
		
		mouseDragPoint = globalToLocal(new Point(gx, gy));
		var mat = new Matrix();
		mat.rotate(rotation / 180 * Math.PI);
		mouseDragPoint = mat.transformPoint(mouseDragPoint);
	}
	
	function addTab(tab:Tab):UInt {
		
		trace("addtab("+tab);
		lastTab = tabs.length > 0?tabs[tabs.length - 1]:null;
		/*
		if (tabs.length == 0) {
			setCurrentTab(tab);
		}
		else {
			setCurrentTab(tabs[0]);
		}*/
		tabs.push(tab);
		
		tab.label.x = ((lastTab != null)?lastTab.label.x + lastTab.label.width:0) + 16;
		//tab.x = tab.y = 32;
		//tab.label.y = 16;
		addChild(tab);
		tab.x = -tab.width / 2;
		tab.y = -tab.height / 2;
		tab.label.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent) {
			if (tab != currentTab)
			{
				setCurrentTab(tab);
			}
		});
		
		cover.draw();
		addChild(cover);
		
		return tabs.length - 1;
	}
	
	public function setCurrentTab(tab:Tab) {
		trace("setCurrentTab(" + tab);
		
		addChild(tab);
		
		//if(currentTab!=null&&currentTab.parent==this)	;
		currentTab = tab;
		for (anyTab in tabs) {
			anyTab.disactivate();
		}
		currentTab.activate();
		addChild(cover);
	}
	
	public function open(evt:MouseEvent = null) {
		buttonMode = false;
		useHandCursor = false;
		removeHalo(null);
		filters = [];
		removeEventListener(MouseEvent.MOUSE_OVER, drawHalo);
		removeEventListener(MouseEvent.MOUSE_OUT, removeHalo);
		
		trace("open(" + evt);
		mouseChildren = true;
		removeEventListener(MouseEvent.MOUSE_UP, open);
		alpha = 1;
		isOpened = true;
		isOpenedChanged.dispatch(isOpened);
		Actuate.tween(cover, 0.5, { rotationX:-240 } ).ease(Quad.easeOut);
		if(parent != null)
			Actuate.tween(parent, 0.5, { rotationX: 0, z:0, y:0} ).ease(Quad.easeOut);
	}
	
	public function close()
	{
		buttonMode = true;
		useHandCursor = true;
		
		filters = [dropShadow];
		
		addEventListener(MouseEvent.MOUSE_OVER, drawHalo);
		addEventListener(MouseEvent.MOUSE_OUT, removeHalo);
		
		trace("close");
		mouseChildren = false;
		isOpened = false;
		//alpha = 0.5;
		addEventListener(MouseEvent.MOUSE_UP, open);
		isOpenedChanged.dispatch(isOpened);
		Actuate.tween(cover, 0.5, { rotationX:0 } ).ease(Quad.easeOut);
		if(parent != null)
			Actuate.tween(parent, 0.5, { rotationX:-60, z:500, y:200} ).ease(Quad.easeOut);
	}
	
	private function removeHalo(e:MouseEvent):Void 
	{
		filters = [dropShadow];
	}
	
	private function drawHalo(e:MouseEvent):Void 
	{
		filters = [new GlowFilter(0xffffff), dropShadow];
	}
	
}