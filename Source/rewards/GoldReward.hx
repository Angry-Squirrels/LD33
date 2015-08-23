package rewards;
import missions.Mission;

/**
 * ...
 * @author Thomas BAUDON
 */
class GoldReward extends Reward
{

	override public function computeQuantity(tier:UInt, mission:Mission){
		var points = mission.requiredStats.getTotal() * 3;
		points *= Std.int((tier*tier/10+1) * mission.teamSize * mission.duration);
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