package rewards;
import missions.Mission;

/**
 * ...
 * @author Thomas BAUDON
 */
class GoldReward extends Reward
{

	override public function computeQuantity(tier:UInt, mission:Mission){
		var points =	mission.requiredStats.g[Stats.AGILITY] + 
						mission.requiredStats.g[Stats.INTEL] +
						mission.requiredStats.g[Stats.STRENGHT];
		points *= tier * mission.teamSize * mission.duration;
		mQuantity = points;
	}
	
	override public function take() 
	{
		GameManager.getInstance().gold += mQuantity;
	}
	
	public function toString() : String {
		return "$"+mQuantity;
	}
	
}