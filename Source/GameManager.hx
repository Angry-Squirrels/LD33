package;
import haxe.Json;
import missions.Mission;
import monsters.Monster;
import msignal.Signal.Signal0;

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
	
	public var availableMissions : Array<Mission>;
	public var availableMissionsChanged:Signal0;
	public var ongoingMissions : Array<Mission>;
	public var ongoingMissionsChanged:Signal0;
	public var endedMission : Array<Mission>;
	public var endedMissionsChanged:Signal0;
	public var archivedMission : Array<Mission>;
	public var archivedMissionsChanged:Signal0;
	public var maxMissionNb : UInt = 5;
	
	public var gold : Int;
	public var day : UInt;
	public var maxDay : UInt;
	public var config : Dynamic;
	
	function new() 
	{
		// load config
		var rawText : String = "";
		#if neko
		rawText = File.getContent("Assets/missions/missions.json");
		#else
		rawText = Assets.getText("missions/missions.json");
		#end
		config = Json.parse(rawText);
		
		monsters = new Array<Monster>();
		availableMissions = new Array<Mission>();
		availableMissionsChanged = new Signal0();
		ongoingMissions = new Array<Mission>();
		ongoingMissionsChanged = new Signal0();
		endedMission = new Array<Mission>();
		endedMissionsChanged = new Signal0();
		archivedMission = new Array<Mission>();
		archivedMissionsChanged = new Signal0();
		
		day = 0;
		maxDay = 42;
		gold = 1000;
	}
	
	public function addMonster() {
		monsters.push(Monster.get(getMonstersTiers()));
	}
	
	public function addMission(type : String = "") {
		var missionTier : Int = Std.int(getMonstersTiers()) + Std.random(5) - 2;
		if (missionTier < 1) missionTier = 1;
		availableMissions.push(Mission.get(missionTier, type));
		availableMissionsChanged.dispatch();
	}
	
	public function getMonstersTiers() : UInt {
		var moy : Float = 0;
		for (monster in monsters) 
			moy += monster.stats.getTier();
		moy /= monsters.length;
		moy = Math.ceil(moy);
		if (moy == 0) moy = 1;
		return Std.int(moy);
	}
	
	public function startNewDay() {
		day++;
		
		message("A new sun arise... Day " + day);
		
		
		for(i in 0 ... maxMissionNb){
			if (availableMissions.length < cast maxMissionNb)
				addMission();
			else
				break;
		}
		
		for (mission in ongoingMissions) {
			mission.remainingTime--;
			if (mission.remainingTime < 0){ 
				endedMission.push(mission);
				mission.end();
			}
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
	}
	
	public function endDay() {
		message("A new moon is rising!");
		
		for (monster in monsters) {
			gold -= monster.costOfLife;
			message(monster.name + " costed you " + monster.costOfLife + " to stay alive.");
		}
		
		startNewDay();
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
		archivedMission.push(mission);
		archivedMissionsChanged.dispatch();
		mission.onRepportRead();
	}
	
	public function launchMission(mission : Mission) {
		if (mission.assignedMonsters.length > 0){
			availableMissions.remove(mission);
			availableMissionsChanged.dispatch();
			mission.remainingTime = mission.duration;
			ongoingMissions.push(mission);
			ongoingMissionsChanged.dispatch();
			mission.started = true;
			message("Mission " + mission.title + " launched.");
		}
	}
	
	
	
}