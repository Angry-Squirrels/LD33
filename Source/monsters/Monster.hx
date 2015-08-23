package monsters;
import missions.Mission;
import NameGenerator;
import openfl.Assets;
import openfl.display.BitmapData;


/**
 * ...
 * @author Thomas BAUDON
 */
class Monster
{
	public var currentMission : Mission;
	
	public var stats : Stats;
	
	public var traits : String;
	
	public var name : String;
	public var picture:BitmapData;
	
	public static function get(tier : UInt = 1) : Monster {
		var monster = new monsters.Monster();
		monster.name = NameGenerator.getName();
		monster.stats = Stats.make(tier);	
		monster.traits = Traits.getRandomTrait();
		
		monster.picture = Assets.getBitmapData("images/monster.png");
		
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