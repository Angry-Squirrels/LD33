package;

import missions.Mission;
import missions.MissionBinder;
import missions.MissionSheet;
import missions.ReportFile;
import monsters.Monster;
import monsters.MonsterBinder;
import monsters.MonsterListSheet;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
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
		monsterBinder.monsterPicked.add(addMonsterToMission);
		
		
		//monsterFile.x = monsterFile.y = 16;
		
		
		
		missionBinder = new MissionBinder();
		missionBinder.monsterRequested.add(openMonsterList);
		
		missionBinder.x = 400;
		missionBinder.rotation = 5;
		//reportFile = new ReportFile();
		//researchFile = new File();
		
		addChild(monsterBinder);
		addChild(missionBinder);
		//addChild(monsterFile);
		
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
	
	function addMonsterToMission(monster:Monster) 
	{
		trace("addMonsterToMission(" + monster);
		cast(missionBinder.availablePile.getCurrentSheet(), MissionSheet).addMonster(monster);
		monsterBinder.listSheet.pickMode = false;
		monsterBinder.close();
	}
	
	function openMonsterList() 
	{
		trace("openMonsterList");
		monsterBinder.listSheet.pickMode = true;
		monsterBinder.open();
		//monsterListSheet.visible = true;
		
	}
	
	
	
}