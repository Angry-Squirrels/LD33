package;
import missions.Mission;
import monsters.Monster;
import msignal.Signal.Signal0;

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
	
	public var gold : UInt;
	public var day : UInt;
	public var maxDay : UInt;
	
	function new() 
	{
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
		availableMissions.push(Mission.get(getMonstersTiers(), type));
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
		
		for (mission in ongoingMissions) {
			mission.remainingTime--;
			if (mission.remainingTime < 0) {
				endedMission.push(mission);
				endedMissionsChanged.dispatch();
			}
		}
		
		for (mission in endedMission) {
			mission.end();
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
		}
	}
	
	
	
}