package ui;
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

	public function new() 
	{
		super();
		
		tabs = new Array<Tab>();
		
	}
	
	function addTab(tab:Tab):UInt {
		
		trace("addtab");
		var lastTab = tabs.length> 0?tabs[tabs.length - 1]:null;
		tabs.push(tab);
		
		tab.label.x = ((lastTab != null)?lastTab.label.x + lastTab.label.width:0) + 16;
		//tab.x = tab.y = 32;
		addChild(tab);
		tab.label.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent) {
			setCurrentTab(tab);
		});
		
		return tabs.length - 1;
	}
	
	function setCurrentTab(tab:Tab) {
		currentTab.swapChildren(tab, currentTab);
		currentTab = tab;
	}
	
}