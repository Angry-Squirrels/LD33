package;

import missions.Mission;
import missions.MissionSheet;
import monsters.Monster;
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

	public function new() 
	{
		super();
		
		desk = new Desk();
		
		monsterFile = new File();
		missionFile = new File();
		researchFile = new File();
		
		var monster = Monster.get();
		
		
		var mission = Mission.get();
		var missionSheet = new MissionSheet(mission);
		
		addChild(desk);
		
		addChild(missionSheet);
		
		
	}
	
}