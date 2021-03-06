package;
import haxe.EnumTools.EnumValueTools;
import haxe.Json;
import missions.Mission;
import missions.sheets.AvailableMissionSheet;
import monsters.Monster;
import msignal.Signal.Signal0;
import msignal.Signal.Signal1;

#if !neko
import openfl.Assets;
#else
import sys.io.File; 
#end


/**
 * ...
 * @author Thomas BAUDON
 */
class GameManager
{
	
	static var mInstance : GameManager;

	public static function getInstance() : GameManager {
		if (mInstance == null)
			mInstance = new GameManager();
		return mInstance;
	}

	public var monsters : Array<Monster>;
	public var monstersChanged:Signal0;
	
	public var availableMissions : Array<Mission>;
	public var availableMissionsChanged:Signal0;
	public var ongoingMissions : Array<Mission>;
	public var ongoingMissionsChanged:Signal0;
	public var endedMission : Array<Mission>;
	public var endedMissionsChanged:Signal0;
	public var archivedMissions : Array<Mission>;
	public var archivedMissionsChanged:Signal0;
	
	public var messages : Array<String>;
	
	static public inline var maxMissionNb : Int = 10;
	static public inline var maxMonsterNb : Int = 5;
	static public inline var objective : UInt = 10000;
	static public inline var startGold : UInt = 1000;
	
	var saidSup2 : Bool;
	var saidSup5 : Bool;
	var saidSup7 : Bool;
	var saidSup9 : Bool;
	
	var saidInf2 : Bool;
	var saidInf5 : Bool;
	var saidInf10 : Bool;
	
	public var market : MonsterMarket;
	
	public var gold(get, set) : Int;
	var _gold:Int;
	public var goldChanged:Signal1<Int>;
	public var day : Int;
	public var config : Dynamic;
	
	function new() 
	{
		// load config
		var rawText : String = "";
		#if neko
		rawText = File.getContent("Assets/missions/config.json");
		#else
		rawText = Assets.getText("missions/config.json");
		#end
		config = Json.parse(rawText);
		
		messages = new Array<String>();
		
		monsters = new Array<Monster>();
		monstersChanged = new Signal0();
		
		availableMissions = new Array<Mission>();
		availableMissionsChanged = new Signal0();
		ongoingMissions = new Array<Mission>();
		ongoingMissionsChanged = new Signal0();
		endedMission = new Array<Mission>();
		endedMissionsChanged = new Signal0();
		archivedMissions = new Array<Mission>();
		archivedMissionsChanged = new Signal0(); 
		market = new MonsterMarket(this);
		
		day = 1;
		goldChanged = new Signal1<Int>();
		gold = startGold;
	}
	
	public function addMonster() {
		monsters.push(Monster.get(getMonstersTiers()));
		monstersChanged.dispatch();
	}
	
	public function addMission(type : String = "") {
		var missionTier : Int = Std.int(getMonstersTiers()) + Std.random(5) - 2;
		if (missionTier < 1) missionTier = 1;
		availableMissions.push(Mission.get(missionTier, type));
		availableMissionsChanged.dispatch();
	}
	
	public function getMonstersTiers() : Int {
		var moy : Float = 0;
		for (monster in monsters) 
			moy += monster.stats.getLevel();
		moy /= monsters.length;
		moy = Math.ceil(moy);
		if (moy == 0) moy = 1;
		return Std.int(moy);
	}

	public function startNewDay() {		
		day++;
		
		trace("A new sun arise... Day " + day + ".");
		market.newDay();
		
		for (mission in ongoingMissions) {
			mission.remainingTime--;
			mission.remainingTimeChanged.dispatch(mission.remainingTime);
			if (mission.remainingTime < 0){ 
				endedMission.push(mission);
				mission.end();
				endedMissionsChanged.dispatch();
			}
		}
		
		for (mission in endedMission) {
			ongoingMissions.remove(mission);
			ongoingMissionsChanged.dispatch();
		}
		
		addBaseMissions();
	}
	
	public function addBaseMissions() {
		// check that a capture mission is available
		var captureAvailable = false;
		for (mission in availableMissions)
			if (mission.type == "Capture") {
				captureAvailable = true;
				break;
			}
			
		if (!captureAvailable)
			addMission("Capture");
			
		// check that a prospect mission is available
		var prospectAvailable = false;
		for (mission in availableMissions)
			if (mission.type == "Prospect") {
				prospectAvailable = true;
				break;
			}
			
		if (!prospectAvailable)
			addMission("Prospect");	
	}
	
	public function endDay() : Bool {
		trace("A new moon is rising!");
		
		if (day == 1) {
			message("Rent-A-Monster");
			message("A Ludum Dare entry by:\n\n" + 
					"\t\t- @damrem\n\n" +
					"\t\t- @thomas_baudon\n\n" +
					"\t\t- Music by Kevin MacLeod");
		}
		
		if (gold < startGold / 10 && !saidInf10){ 
			message("You're not my son anymore.");
			saidInf10 = true;
		}
		else if (gold < startGold / 5 && !saidInf5){ 
			message("Son, I'm deeply disappointed. Start making actual money and maybe I'll reconsider my opinion.");
			saidInf5 = true;
		}
		else if (gold < startGold / 2 && !saidInf2) {
			message("Son, I see you have less than half the money I gave you to establish our financial superiority in this world.\n\n" +
					"\tStop fooling arround and start exploiting those pesky monster!");
			saidInf2 = true;
		}
			
		if (gold > Std.int(startGold * 9) && !saidSup9){
			message("What exactly didn't you understand in \"As fats as possible\" ?\n\nWe need that money!");
			saidSup9 = true;
		}
		else if (gold > Std.int(startGold * 7.5) && !saidSup7){
			message("Come on, you can't be my son. I was far more tallented than you at the same age. Could you send me some saliva samples ?");
			saidSup7 = true;
		}
		else if (gold > Std.int(startGold * 5) && !saidSup5){
			message("You're not getting rich anytime soon at this rate!");
			saidSup5 = true;
		}
		else if (gold > Std.int(startGold * 2) && !saidSup2){
			message("Did it really take you " + getDate() + " days only to double the amount I gave you ?");
			saidSup2 = true;
		}
		
		
		var monsterToKill = new Array<Monster>();
		
		for (monster in monsters) {
			
			var chanceOfDeath = 0.05;
			var rollChance = Math.random();
			var die = rollChance < chanceOfDeath;
			if (monster.currentMission == null) die = false;
			if(!die){ 
				gold -= monster.costOfLife;
				message(monster.name + " costed you " + monster.costOfLife + " to stay alive.");
			}else {
				monster.alive = false;
				
				var msgs =
				[
					monster.name + " died from exhaustion while working on " + monster.currentMission.title,
					monster.name + " died at work. Loser!",
					monster.name + " died just before you could have sold it. It's a shame!"
				];
				
				message(msgs[Std.random(msgs.length)]);
				monsterToKill.push(monster);
				monster.currentMission.unassignMonster(monster);
			}
		}
		
		if (monsterToKill.length > 0) {
			while (monsterToKill.length > 0)
				monsters.remove(monsterToKill.pop());
			monstersChanged.dispatch();
		}
		
		if (gold >= 0)
			if (_gold < objective) {
				
				return false;
			}
			else {
				trace("objective reached");
				return true;
			}
		else {
			trace("no money:");
			return true;
		}
	}
	
	function endGame() 
	{
		message("This is the end ! Your final score : " + gold);
	}
	
	function gameOver() 
	{
		message("You're a fucking looser!");
	}
	
	public function getFreeMonster() : Array<Monster> {
		var rep = new Array<Monster>();
		for (monster in monsters)
			if (monster.currentMission == null)
				rep.push(monster);
				
		return rep;
	}
	
	public function getDate() : UInt {
		return day;
	}
	
	public function message(message : String) {
		#if neko
		neko.Lib.println(message);
		#else
		messages.push(message);
		#end
	}
	
	public function archiveMission(mission : Mission) {
		endedMission.remove(mission);
		archivedMissions.push(mission);
		archivedMissionsChanged.dispatch();
		mission.onRepportRead();
		endedMissionsChanged.dispatch();
	}
	
	public function launchMission(mission : Mission) {
		if (mission.assignedMonsters.length > 0 && mission.areRequirementFilled()){
			availableMissions.remove(mission);
			availableMissionsChanged.dispatch();
			mission.remainingTime = mission.duration;
			mission.remainingTimeChanged.dispatch(mission.remainingTime);
			ongoingMissions.push(mission);
			ongoingMissionsChanged.dispatch();
			mission.started = true;
		}else {
			if (mission.assignedMonsters.length < 1)
			{
				trace("No monster assigned to this mission.");
			}
			else if (!mission.areRequirementFilled())
			{
				trace("Your monsters doesn't fill the requirements for this mission.");
			}
			for (monster in mission.assignedMonsters)
			{
				mission.unassignMonster(monster);
			}
		}
	}
	
	public function dissmissMission(mission:Mission) 
	{
		availableMissions.remove(mission);
		availableMissionsChanged.dispatch();
		for (monster in mission.assignedMonsters){
			monster.currentMission = null;
			monster.currentMissionChanged.dispatch(null);
		}
	}
	
	function get_gold():Int 
	{
		return _gold;
	}
	
	function set_gold(value:Int):Int 
	{
		_gold = value;
		goldChanged.dispatch(_gold);
		return  _gold;
	}
	
	
	
}