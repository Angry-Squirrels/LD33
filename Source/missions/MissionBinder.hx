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
	var runningTab:Tab;
	var availableTab:Tab;

	
	
	public function new() 
	{
		trace("missionBinder");
		super("Missions", 320, 512);
		gameManager = GameManager.getInstance();
		
		monsterRequested = new Signal0();
		availableTab = new Tab("Available", 304, 416);
		
		availablePile = new SheetPile(304, 424);
		availablePile.y = 32;
		availableTab.addChild(availablePile);
		gameManager.availableMissionsChanged.add(updateAvailable);
		
		runningTab = new Tab("Running", 304, 416);
		runningPile = new SheetPile(304, 424);
		runningPile.y = 32;
		runningTab.addChild(runningPile);
		gameManager.ongoingMissionsChanged.add(updateRunning);
		
		updateAvailable();
		addTab(availableTab);

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
		
		updateBg();
	}
	
	function updateBg() 
	{
		bg.height = Math.max(runningTab.height, availableTab.height) + vMargin;
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
		
		updateBg();
	}
	
	
	
	
	
}