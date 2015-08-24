package monsters;

import monsters.MonsterListSheet;
import msignal.Signal.Signal0;
import msignal.Signal.Signal1;
import openfl.filesystem.File;
import ui.Binder;
import ui.Tab;

/**
 * ...
 * @author damrem
 */
class MonsterBinder extends Binder
{
	public var monsterPicked:Signal1<Monster>;
	public var listSheet:MonsterListSheet;

	public function new() 
	{
		super("Monsters");
		
		monsterPicked = new Signal1<Monster>();
		
		var tab = new Tab("Monster");
		
		listSheet = new MonsterListSheet();
		listSheet.monsterPicked.add(monsterPicked.dispatch);
		listSheet.y = 32;
		tab.addChild(listSheet);
		
		addTab(tab);
	}
	
}