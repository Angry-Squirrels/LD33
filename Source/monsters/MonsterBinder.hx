package monsters;

import monsters.MonsterListSheet;
import msignal.Signal.Signal0;
import msignal.Signal.Signal1;
import openfl.events.MouseEvent;
import openfl.filesystem.File;
import ui.Binder;
import ui.Tab;

/**
 * ...
 * @author damrem
 */
class MonsterBinder extends Binder
{
	public var monstersTab:ui.Tab;
	public var marketTab:ui.Tab;
	public var monsterPicked:Signal1<Monster>;
	public var listSheet:MonsterListSheet;

	public function new() 
	{
		super("Monsters");
		
		monsterPicked = new Signal1<Monster>();
		
		monstersTab = new Tab("Monsters", 304, 360);
		
		listSheet = new MonsterListSheet();
		listSheet.monsterPicked.add(monsterPicked.dispatch);
		listSheet.pickModeChanged.add(function(pickMode:Bool) {
			
		});
		listSheet.y = 32;
		monstersTab.addChild(listSheet);
		
		addTab(monstersTab);
		
		
		marketTab = new Tab("Buy-a-Monster", 304, 360);
		
		var marketSheet = new MarketSheet();
		marketSheet.y = 32;
		marketTab.addChild(marketSheet);
		
		addTab(marketTab);
		
		setCurrentTab(monstersTab);
		
		
	}
	
	override public function open(evt:MouseEvent = null)
	{
		if (listSheet.pickMode)
		{
			setCurrentTab(monstersTab);
			marketTab.visible = false;
		}
		else
		{
			marketTab.visible = true;
		}
		super.open(evt);
	}
	
	override public function close(cancelPicking:Bool=false)
	{
		if (cancelPicking)
		{
			listSheet.cancelPicking();
		}
		super.close();
	}
	
}