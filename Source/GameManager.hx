package;
import haxe.Json;
import missions.Mission;
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
	
	static public inline var maxMissionNb : Int = 10;
	static public inline var maxMonsterNb : Int = 5;
	static public inline var maxTime : Int = 30;
	
	public var market : MonsterMarket;
	
	public var gold(get, set) : Int;
	var _gold:Int;
	public var goldChanged:Signal1<Int>;
	public var day : Int;
	public var remainingTime : Int;
	public var maxDay : UInt;
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
		
		day = 0;
		maxDay = 42;
		goldChanged = new Signal1<Int>();
		gold = 1000;
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
		
		remainingTime = GameManager.maxTime - day;
		message("A new sun arise... Day " + day + " / " + GameManager.maxTime);
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
		message("A new moon is rising!");
		
		for (monster in monsters) {
			gold -= monster.costOfLife;
			message(monster.name + " costed you " + monster.costOfLife + " to stay alive.");
		}
		
		if (gold >= 0)
			if(remainingTime > 0)
				return true;
			else
				return false;
		else
			return false;
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
		trace(message);
		#end
	}
	
	public function archiveMission(mission : Mission) {
		endedMission.remove(mission);
		endedMissionsChanged.dispatch();
		archivedMissions.push(mission);
		archivedMissionsChanged.dispatch();
		mission.onRepportRead();
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
			message("Mission " + mission.title + " launched.");
		}else {
			if (mission.assignedMonsters.length < 1)
				message("No monster assigned to this mission.");
			else if (!mission.areRequirementFilled())
				message("Your monsters doesn't fill the requirements for this mission.");
			for (monster in mission.assignedMonsters)
				mission.unassignMonster(monster);
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