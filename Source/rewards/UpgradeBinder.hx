package rewards;

import ui.Binder;
import ui.Tab;

/**
 * ...
 * @author damrem
 */
class UpgradeBinder extends Binder
{

	public function new() 
	{
		super();
		
		var tab = new Tab("Upgrades");
		addTab(tab);
		
		var sheet = new UpgradeSheet();
		tab.addChild(sheet);
		
	}
	
}