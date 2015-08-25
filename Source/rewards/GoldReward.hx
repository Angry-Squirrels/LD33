package rewards;
import missions.Mission;
import monsters.Monster;

/**
 * ...
 * @author Thomas BAUDON
 */
class GoldReward extends Reward
{

	override public function computeQuantity(tier:UInt, mission:Mission){
		var points = mission.requiredStats.getTotal() * 3;
		points *= Std.int((tier*tier/10+1) * mission.teamSize * mission.duration);
		var rewardBonus = 1 + Upgrades.betterMissionRewardUpgrade * 0.05;
		mQuantity = Std.int(points * rewardBonus);
	}
	
	override public function take(monsters : Array<Monster>) {
		GameManager.getInstance().gold = GameManager.getInstance().gold + mQuantity;
	}
	
	public function toString() : String {
		return "$"+mQuantity;
	}
	
}