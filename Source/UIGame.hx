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
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import rewards.UpgradeBinder;
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
	var upgradeBinder:UpgradeBinder;
	var upgrade3dContainer:Sprite;
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
		desk.addEventListener(MouseEvent.CLICK, onClickDesk);
		addChild(desk);
		
		dayBlackTransition = new Sprite();
		dayBlackTransition.graphics.beginFill(0);
		dayBlackTransition.graphics.drawRect(0, 0, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
		
		gameManager.message("Son,\n"+
							"I sent you here to extend the Company.\n\n" + 
							"Don't disapoint me.\n\n" +
							"\tYou're on a trial and have a month to maximize your incomes." +
							"This world is full of cheap workforce! Use it!\n\n" +
							"\tAll the folder you need are on your desk.\n\n" +
							"\tYou'll first need a sla... employee to send him in mission.\n\n" +
							"\tUse the monster folder\n" + 
							"to bu... recruit one in the market section.\n\n" +
							"Then use the mission folder to send him into mission!\n" +
							"Good luck !");
							
		gameManager.market.newDay();
		
		binderContainer = new Sprite();
		
		upgradeBinder = new UpgradeBinder();
		upgradeBinder.x = 600;
		upgradeBinder.y = 300;
		upgradeBinder.rotation = Math.random() * 20 - 10;
		
		upgrade3dContainer = new Sprite();
		binderContainer.addChild(upgrade3dContainer);
		upgrade3dContainer.addChild(upgradeBinder);
		upgrade3dContainer.rotationX = -60;
		upgrade3dContainer.z = 500;
		upgrade3dContainer.y = 200;
		
		monsterBinder = new MonsterBinder();
		monsterBinder.x = 150;
		monsterBinder.y = 300;
		monsterBinder.rotation = -10;
		
		monster3dContainer = new Sprite();
		binderContainer.addChild(monster3dContainer);
		monster3dContainer.addChild(monsterBinder);
		monster3dContainer.rotationX = -60;
		monster3dContainer.z = 500;
		monster3dContainer.y = 200;
		
		missionBinder = new MissionBinder();
		missionBinder.x = 450;
		missionBinder.y = 300;
		missionBinder.rotation = 10;
		
		mission3dContainer = new Sprite();
		binderContainer.addChild(mission3dContainer);
		mission3dContainer.addChild(missionBinder);
		mission3dContainer.rotationX = -60;
		mission3dContainer.z = 500;
		mission3dContainer.y = 200;
		
		reportBinder = new ReportBinder();
		reportBinder.x = 300;
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
		upgradeBinder.isOpenedChanged.add(openUpgradeBinder);
		
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
		
		dayBlackTransition.alpha = 1;
		Lib.current.stage.addChild(dayBlackTransition);
		fadeIn(checkRepport,1);
	}
	
	private function onClickDesk(e:MouseEvent):Void 
	{
		trace("desk");
		missionBinder.close(true);
		reportBinder.close();
		monsterBinder.close(true);
		upgradeBinder.close();
	}
	
	function openMissionBinder(isOpened:Bool) 
	{
		if (isOpened) {
			binderContainer.addChild(mission3dContainer);
			monsterBinder.close(true);
			reportBinder.close();
			upgradeBinder.close();
		}
	}
	
	function openMonsterBinder(isOpened:Bool) 
	{
		if (isOpened) {
			binderContainer.addChild(monster3dContainer);
			missionBinder.close(true);
			reportBinder.close();
			upgradeBinder.close();
		}
	}
	
	function openReportBinder(isOpened:Bool) 
	{
		if (isOpened) {
			binderContainer.addChild(repport3dContainer);
			missionBinder.close(true);
			monsterBinder.close(true);
			upgradeBinder.close();
		}
	}
	
	function openUpgradeBinder(isOpened:Bool)
	{
		if (isOpened)
		{
			binderContainer.addChild(upgrade3dContainer);
			missionBinder.close(true);
			monsterBinder.close(true);
			reportBinder.close();
		}
	}
	
	function addMonsterToMission(monster:Monster) 
	{
		trace("addMonsterToMission(" + monster);
		cast(missionBinder.availablePile.getCurrentSheet(), AvailableMissionSheet).addMonster(monster);
		monsterBinder.listSheet.cancelPicking();
		//monsterBinder.close();
		missionBinder.open();
	}
	
	function openMonsterListForPicking() 
	{
		trace("openMonsterList");
		monsterBinder.listSheet.pickMode = true;
		monsterBinder.listSheet.update();
		
		monsterBinder.open();
		
		//monsterListSheet.visible = true;
		
	}
	
	function fadeOut(onComplete : Dynamic) {
		dayBlackTransition.alpha = 0;
		Lib.current.stage.addChild(dayBlackTransition);
		Actuate.tween(dayBlackTransition, 0.25, { alpha:1 } ).ease(Cubic.easeOut).onComplete(onComplete);
	}
	
	function fadeIn(onComplete : Dynamic, duration : Float = 0.25) {
		Actuate.tween(dayBlackTransition, duration, { alpha:0 } ).ease(Cubic.easeOut).onComplete(function() {
			Lib.current.stage.removeChild(dayBlackTransition);
			onComplete();
		});
	}
	
	public function dayTransition(start : Bool = false) {
		fadeOut(checkEndGame);
	}
	
	function checkEndGame() {
		var end = gameManager.endDay();
		if (!end) {
			gameManager.startNewDay();
			calendar.updateDate();
			fadeIn(checkRepport);
		}else {
			trace("this is the end.");
		}
	}
	
	function checkRepport() {
		var openReport = false;
				
		if (gameManager.messages.length > 0){
			reportBinder.addMessagePage();
			openReport = true;
		}
		
		if (gameManager.endedMission.length > 0)
			openReport = true;
		
		if (openReport)
			reportBinder.open();
	}
	
	
	
}