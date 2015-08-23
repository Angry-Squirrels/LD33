package monsters;

import monsters.MonsterListSheet;
import openfl.filesystem.File;
import ui.Binder;
import ui.Tab;

/**
 * ...
 * @author damrem
 */
class MonsterBinder extends Binder
{
	var monsterListSheet:MonsterListSheet;

	public function new() 
	{
		super();
		
		var tab = new Tab("Monster");
		
		monsterListSheet = new MonsterListSheet();
		monsterListSheet.y = 32;
		tab.addChild(monsterListSheet);
		
		addTab(tab);
	}
	
}