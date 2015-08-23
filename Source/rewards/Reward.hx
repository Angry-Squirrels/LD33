package rewards;
import missions.Mission;
import monsters.Monster;

/**
 * ...
 * @author Thomas BAUDON
 */
class Reward
{
	
	var mQuantity : UInt = 0;

	public function new() 
	{
		
	}
	
	public function computeQuantity(tier:UInt, mission:Mission){
	}
	
	// monsters are the monster who took part in the mission, so you can give bonuses if you assigned good monsters
	public function take(monsters : Array<Monster>) {
		trace("You take " + this);
	}
	
}