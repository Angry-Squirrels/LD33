package missions;


import missions.sheets.AvailableMissionSheet;
import missions.sheets.RunningMissionSheet;
import msignal.Signal.Signal0;
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
	public var monsterRequested:Signal0;
	public var availablePile:SheetPile;
	public var runningPile:SheetPile;
	var gameManager:GameManager;

	
	
	public function new() 
	{
		trace("missionBinder");
		super();
		gameManager = GameManager.getInstance();
		
		monsterRequested = new Signal0();
		var availableTab:Tab = new Tab("Available");
		availablePile = new SheetPile(384, 464);
		availablePile.y = 32;
		availableTab.addChild(availablePile);
		gameManager.availableMissionsChanged.add(updateAvailable);
		updateAvailable();
		addTab(availableTab);
		
		var runningTab:Tab = new Tab("Running");
		runningPile = new SheetPile(384, 464);
		runningPile.y = 32;
		runningTab.addChild(runningPile);
		gameManager.ongoingMissionsChanged.add(updateRunning);
		updateRunning();
		addTab(runningTab);
		
		setCurrentTab(availableTab);
		
		
		
		
	}
	
	function updateRunning() 
	{
		runningPile.empty();
		
		var missions = gameManager.ongoingMissions;
		for (mission in missions) {
			var missionSheet = new RunningMissionSheet(mission);
			runningPile.addSheet(missionSheet);
		}
	}
	
	function updateAvailable() {
		
		availablePile.empty();
		
		var missions = gameManager.availableMissions;
		for(mission in missions)
		{
			var missionSheet = new AvailableMissionSheet(mission);
			missionSheet.monsterRequested.add(monsterRequested.dispatch);
			availablePile.addSheet(missionSheet);
		}
	}
	
	
	
	
	
}