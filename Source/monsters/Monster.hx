package monsters;
import NameGenerator;


/**
 * ...
 * @author Thomas BAUDON
 */
class Monster
{
	public var busy : Bool;
	
	public var stats : Stats;
	
	public var traits : String;
	
	public var name : String;
	
	public static function get(tier : UInt = 1) : Monster {
		var monster = new monsters.Monster();
		monster.name = NameGenerator.getName();
		monster.stats = Stats.make(tier);	
		monster.traits = Traits.getRandomTrait();
		
		return monster;
	}

	public function new() 
	{
		stats = new Stats();
	}
	
	public function toString() : String {
		return name + " stats : " + stats;
	}
	
}