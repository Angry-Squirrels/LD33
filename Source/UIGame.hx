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
	var monsterFile:Binder;
	var missionFile:Binder;
	var gameManager:GameManager;
	var monsterListSheet:monsters.MonsterListSheet;
	var missionSheet:missions.MissionSheet;
	var mission:missions.Mission;
	var reportFile:missions.ReportFile;
	

	public function new(gameManager:GameManager) 
	{
		super();
		this.gameManager = gameManager;
		
		desk = new Desk();
		
		monsterFile = new MonsterBinder();
	
		//monsterFile.x = monsterFile.y = 16;
		
		
		
		missionFile = new MissionBinder();
		
		missionFile.x = 400;
		reportFile = new ReportFile();
		//researchFile = new File();
		
		addChild(monsterFile);
		addChild(missionFile);
		//addChild(monsterFile);
		
		/*
		
		
		var monster = Monster.get();
		
		monsterListSheet = new MonsterListSheet(gameManager);
		monsterListSheet.visible = false;
		
		mission = gameManager.availableMissions[0];
		missionSheet = new MissionSheet(mission);
		missionSheet.x = 200;

		
		monsterListSheet.monsterPicked.add(addMonsterToMission);
		
		missionSheet.monsterRequested.add(openMonsterList);
		
		
		addChild(desk);
		
		addChild(missionSheet);
		addChild(monsterListSheet);
		*/
		
	}
	
	function addMonsterToMission(monster:Monster) 
	{
		trace("addMonsterToMission(" + monster);
		missionSheet.addMonster(monster);
		monsterListSheet.visible = false;
	}
	
	function openMonsterList() 
	{
		monsterListSheet.pickMode = true;
		monsterListSheet.visible = true;
		
	}
	
	
	
}