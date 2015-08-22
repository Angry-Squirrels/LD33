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
		trace("Game manager launched");
		
		monsters = new Array<Monster>();
		availableMissions = new Array<Mission>();
		ongoingMissions = new Array<Mission>();
		
		day = 0;
		maxDay = 42;
		
		
	}
	
	public function addMonster() {
		monsters.push(Monster.get(getMonstersTiers()));
	}
	
	public function getMonstersTiers() : UInt {
		var moy : Float = 0;
		for (monster in monsters) 
			moy += monster.stats.getTier();
		moy /= monsters.length;
		moy = Math.ceil(moy);
		return Std.int(moy);
	}
	
	public function startNewDay() {
		day++;
	}
	
	public function getDate() : UInt {
		return day;
	}
	
	
	
}