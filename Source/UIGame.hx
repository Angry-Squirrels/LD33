package;

import missions.sheets.AvailableMissionSheet;
import missions.Mission;
import missions.MissionBinder;
import missions.sheets.AbstractMissionSheet;
import rewards.ReportBinder;
import monsters.Monster;
import monsters.MonsterBinder;
import monsters.MonsterListSheet;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import ui.Calendar;
import ui.Desk;
import ui.Binder;

/**
 * ...
 * @author damrem
 */
class UIGame extends Sprite
{
	
	var desk:Desk;
	var researchFile:Binder;
	var monsterBinder:MonsterBinder;
	var missionBinder:MissionBinder;
	var gameManager:GameManager;
	var reportBinder:rewards.ReportBinder;
	//var monsterListSheet:monsters.MonsterListSheet;
	//var missionSheet:missions.MissionSheet;
	//var mission:missions.Mission;
	//var reportFile:missions.ReportFile;
	

	public function new(gameManager:GameManager) 
	{
		super();
		this.gameManager = gameManager;
		
		desk = new Desk();
		
		monsterBinder = new MonsterBinder();
		monsterBinder.rotation = -10;

		missionBinder = new MissionBinder();
		missionBinder.x = 400;
		missionBinder.rotation = 5;
		
		reportBinder = new ReportBinder();
		reportBinder.x = 200;
		
		monsterBinder.monsterPicked.add(addMonsterToMission);
		missionBinder.monsterRequested.add(openMonsterListForPicking);
		
		monsterBinder.isOpenedChanged.add(openMonsterBinder);
		missionBinder.isOpenedChanged.add(openMissionBinder);
		reportBinder.isOpenedChanged.add(openReportBinder);
		
		//reportFile = new ReportFile();
		//researchFile = new File();
		
		addChild(reportBinder);
		addChild(monsterBinder);
		addChild(missionBinder);
		//addChild(monsterFile);
		
		var calendar:Calendar = new Calendar();
		addChild(calendar);
		/*
		
		
		var monster = Monster.get();
		
		monsterListSheet = new MonsterListSheet(gameManager);
		monsterListSheet.visible = false;
		
		mission = gameManager.availableMissions[0];
		missionSheet = new MissionSheet(mission);
		missionSheet.x = 200;

		
		monsterListSheet.monsterPicked.add(addMonsterToMission);
		
		
		
		
		addChild(desk);
		
		addChild(missionSheet);
		addChild(monsterListSheet);
		*/
		
	}
	
	function openMissionBinder(isOpened:Bool) 
	{
		if (isOpened) {
			addChild(missionBinder);
			monsterBinder.close();
			reportBinder.close();
		}
	}
	
	function openMonsterBinder(isOpened:Bool) 
	{
		if (isOpened) {
			addChild(monsterBinder);
			missionBinder.close();
			reportBinder.close();
		}
	}
	
	function openReportBinder(isOpened:Bool) 
	{
		if (isOpened) {
			addChild(reportBinder);
			missionBinder.close();
			monsterBinder.close();
		}
	}
	
	function addMonsterToMission(monster:Monster) 
	{
		trace("addMonsterToMission(" + monster);
		cast(missionBinder.availablePile.getCurrentSheet(), AvailableMissionSheet).addMonster(monster);
		monsterBinder.listSheet.pickMode = false;
		//monsterBinder.close();
		missionBinder.open();
	}
	
	function openMonsterListForPicking() 
	{
		trace("openMonsterList");
		monsterBinder.listSheet.pickMode = true;
		monsterBinder.open();
		//monsterListSheet.visible = true;
		
	}
	
	
	
}