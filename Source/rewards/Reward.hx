package rewards;
import missions.Mission;

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
	
	public function onTake() {
		trace("You take " + this);
	}
	
}