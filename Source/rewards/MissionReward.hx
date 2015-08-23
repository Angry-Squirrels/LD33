package rewards;
import missions.Mission;
import monsters.Monster;

/**
 * ...
 * @author Thomas BAUDON
 */
class MissionReward extends Reward
{

	override public function computeQuantity(tier:UInt, mission:Mission) {
		mQuantity = Math.ceil(tier * tier / 2) + 1;
	}
	
	override public function take(monsters:Array<Monster>) 
	{
		for(i in 0 ... mQuantity)
			GameManager.getInstance().addMission("Contract");
	}
	
	public function toString() : String {
		return '$mQuantity missions.';
	}
	
}