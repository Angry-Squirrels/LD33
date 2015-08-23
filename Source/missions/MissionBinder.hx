package missions;


import openfl.display.Sprite;
import ui.Binder;
import ui.SheetPile;
import ui.Tab;

/**
 * ...
 * @author damrem
 */
class MissionBinder extends Binder
{
	var availablePile:SheetPile;
	var gameManager:GameManager;

	
	
	public function new() 
	{
		trace("missionBinder");
		super();
		
		availablePile = new SheetPile(384, 464);
		availablePile.y = 32;
		
		
		gameManager = GameManager.getInstance();
		gameManager.availableMissionsChanged.add(updateAvailable);
		updateAvailable();
		
		var runningTab:Tab = new Tab("Running");
		var availableTab:Tab = new Tab("Available");
		
		availableTab.addChild(availablePile);
		
		addTab(runningTab);
		addTab(availableTab);
	}
	
	function updateAvailable() {
		
		availablePile.empty();
		
		var missions = gameManager.availableMissions;
		for(mission in missions)
		{
			trace(mission);
			var missionSheet = new MissionSheet(mission);
			//missionSheet.x = 200;
			availablePile.addSheet(missionSheet);
			trace(missionSheet.visible);
			trace(missionSheet.parent);
		}
	}
	
	
	
	
	
}