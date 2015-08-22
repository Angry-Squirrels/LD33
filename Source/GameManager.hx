package;
import missions.Mission;
import monsters.Monster;

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
	public var ongoingMissions : Array<Mission>;
	public var gold : UInt;
	public var day : UInt;
	public var maxDay : UInt;
	
	function new() 
	{
		monsters = new Array<Monster>();
		availableMissions = new Array<Mission>();
		ongoingMissions = new Array<Mission>();
		
		day = 0;
		maxDay = 42;
		gold = 1000;
	}
	
	public function addMonster() {
		monsters.push(Monster.get(getMonstersTiers()));
	}
	
	public function addMission(type : String = "") {
		availableMissions.push(Mission.get(getMonstersTiers(), type));
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
	
	
	
}