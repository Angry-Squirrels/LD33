package rewards;
import missions.Mission;

/**
 * ...
 * @author Thomas BAUDON
 */
class MonsterReward extends Reward
{

	override public function computeQuantity(tier:UInt, mission:Mission){
	}
	
	public function toString() : String {
		return mQuantity + " monsters";		
	}
	
}