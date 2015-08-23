package ui;
import msignal.Signal.Signal1;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

/**
 * ...
 * @author damrem
 */
class Binder extends Sprite
{
	
	var tabs:Array<Tab>;
	var currentTab:Tab;
	var lastTab:Tab;
	public var isOpened:Bool;
	public var isOpenedChanged:Signal1<Bool>;

	public function new() 
	{
		super();
		isOpenedChanged = new Signal1<Bool>();
		tabs = new Array<Tab>();
		close();
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
		tab.label.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent) {
			if (tab != currentTab)
			{
				setCurrentTab(tab);
			}
		});
		
		
		
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
	}
	
	public function open(evt:MouseEvent = null) {
		trace("open(" + evt);
		mouseChildren = true;
		removeEventListener(MouseEvent.MOUSE_UP, open);
		alpha = 1;
		isOpened = true;
		isOpenedChanged.dispatch(isOpened);
	}
	
	public function close()
	{
		trace("close");
		mouseChildren = false;
		isOpened = false;
		alpha = 0.5;
		addEventListener(MouseEvent.MOUSE_UP, open);
		isOpenedChanged.dispatch(isOpened);
	}
	
}