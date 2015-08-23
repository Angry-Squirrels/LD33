package;

import missions.Mission;
import missions.MissionSheet;
import monsters.Monster;
import monsters.MonsterListSheet;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import ui.Desk;
import ui.File;

/**
 * ...
 * @author damrem
 */
class UIGame extends Sprite
{
	
	var desk:Desk;
	var researchFile:File;
	var monsterFile:File;
	var missionFile:File;
	var gameManager:GameManager;
	var monsterListSheet:monsters.MonsterListSheet;
	var missionSheet:missions.MissionSheet;
	var mission:missions.Mission;
	

	public function new(gameManager:GameManager) 
	{
		super();
		this.gameManager = gameManager;
		
		desk = new Desk();
		
		monsterFile = new File();
		missionFile = new File();
		researchFile = new File();
		
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