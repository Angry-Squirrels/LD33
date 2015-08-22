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
	

	public function new(gameManager:GameManager) 
	{
		super();
		this.gameManager = gameManager;
		
		desk = new Desk();
		
		monsterFile = new File();
		missionFile = new File();
		researchFile = new File();
		
		var monster = Monster.get();
		
		var monsterListSheet = new MonsterListSheet(gameManager);
		
		var mission = Mission.get();
		var missionSheet = new MissionSheet(mission);
		missionSheet.x = 400;
		
		addChild(desk);
		
		addChild(missionSheet);
		addChild(monsterListSheet);
		
		
	}
	
}