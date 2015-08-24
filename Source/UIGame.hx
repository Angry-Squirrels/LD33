package;

import missions.sheets.AvailableMissionSheet;
import missions.Mission;
import missions.MissionBinder;
import missions.sheets.AbstractMissionSheet;
import missions.ReportBinder;
import monsters.Monster;
import monsters.MonsterBinder;
import monsters.MonsterListSheet;
import motion.Actuate;
import motion.easing.Cubic;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import ui.Calendar;
import ui.Desk;
import ui.Binder;
import ui.DollarIndicator;

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
	var reportBinder:missions.ReportBinder;
	var binderContainer:Sprite;
	var mission3dContainer:openfl.display.Sprite;
	var monster3dContainer:openfl.display.Sprite;
	var repport3dContainer:openfl.display.Sprite;
	//var monsterListSheet:monsters.MonsterListSheet;
	//var missionSheet:missions.MissionSheet;
	//var mission:missions.Mission;
	//var reportFile:missions.ReportFile;
	var dayBlackTransition : Sprite;
	var calendar:Calendar;

	public function new(gameManager:GameManager) 
	{
		super();
		this.gameManager = gameManager;
		
		desk = new Desk();
		addChild(desk);
		
		dayBlackTransition = new Sprite();
		dayBlackTransition.graphics.beginFill(0);
		dayBlackTransition.graphics.drawRect(0, 0, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
		
		binderContainer = new Sprite();
		
		
		monsterBinder = new MonsterBinder();
		monsterBinder.x = 200;
		monsterBinder.y = 300;
		monsterBinder.rotation = -10;
		
		monster3dContainer = new Sprite();
		binderContainer.addChild(monster3dContainer);
		monster3dContainer.addChild(monsterBinder);
		monster3dContainer.rotationX = -60;
		monster3dContainer.z = 500;
		monster3dContainer.y = 200;

		missionBinder = new MissionBinder();
		missionBinder.x = 600;
		missionBinder.y = 300;
		missionBinder.rotation = 10;
		
		mission3dContainer = new Sprite();
		binderContainer.addChild(mission3dContainer);
		mission3dContainer.addChild(missionBinder);
		mission3dContainer.rotationX = -60;
		mission3dContainer.z = 500;
		mission3dContainer.y = 200;
		
		reportBinder = new ReportBinder();
		reportBinder.x = 400;
		reportBinder.y = 300;
		reportBinder.rotation = 0;
		
		repport3dContainer = new Sprite();
		binderContainer.addChild(repport3dContainer);
		repport3dContainer.addChild(reportBinder);
		repport3dContainer.rotationX = -60;
		repport3dContainer.z = 500;
		repport3dContainer.y = 200;
		
		monsterBinder.monsterPicked.add(addMonsterToMission);
		missionBinder.monsterRequested.add(openMonsterListForPicking);
		
		monsterBinder.isOpenedChanged.add(openMonsterBinder);
		missionBinder.isOpenedChanged.add(openMissionBinder);
		reportBinder.isOpenedChanged.add(openReportBinder);
		
		//reportFile = new ReportFile();
		//researchFile = new File();
		
		//binderContainer.addChild(reportBinder);
		//binderContainer.addChild(monsterBinder);
		//binderContainer.addChild(missionBinder);
		//addChild(monsterFile);
		
		calendar = new Calendar(this);
		calendar.x = 80;
		calendar.y = 50;
		addChild(calendar);
		
		var dollarIndic = new DollarIndicator();
		addChild(dollarIndic);
		dollarIndic.x = 800 - dollarIndic.width;
		
		/*
		
		
		var monster = Monster.get();
		
		monsterListSheet = new MonsterListSheet(gameManager);
		monsterListSheet.visible = false;
		
		mission = gameManager.availableMissions[0];
		missionSheet = new MissionSheet(mission);
		missionSheet.x = 200;

		
		monsterListSheet.monsterPicked.add(addMonsterToMission);
		
		
		
		
		
		
		addChild(missionSheet);
		addChild(monsterListSheet);
		*/
		
		//GameManager.getInstance().endedMission.push(Mission.get());
		addChild(binderContainer);
	}
	
	function openMissionBinder(isOpened:Bool) 
	{
		if (isOpened) {
			binderContainer.addChild(mission3dContainer);
			monsterBinder.close();
			reportBinder.close();
		}
	}
	
	function openMonsterBinder(isOpened:Bool) 
	{
		if (isOpened) {
			binderContainer.addChild(monster3dContainer);
			missionBinder.close();
			reportBinder.close();
		}
	}
	
	function openReportBinder(isOpened:Bool) 
	{
		if (isOpened) {
			binderContainer.addChild(repport3dContainer);
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
	
	public function dayTransition() {
		dayBlackTransition.alpha = 0;
		Lib.current.stage.addChild(dayBlackTransition);
		Actuate.tween(dayBlackTransition, 0.25, { alpha:1 } ).ease(Cubic.easeOut).onComplete(function() {	
			var gotoNextDay = gameManager.endDay();
			if (gotoNextDay){
				gameManager.startNewDay();
				calendar.updateDate();
				Actuate.tween(dayBlackTransition, 0.25, { alpha:0 } ).ease(Cubic.easeOut);
			}
		});
	}
	
	
	
}