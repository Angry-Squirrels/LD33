package rewards;
import missions.Mission;
import monsters.Monster;

/**
 * ...
 * @author Thomas BAUDON
 */
class MonsterReward extends Reward
{

	override public function computeQuantity(tier:UInt, mission:Mission) {
		mQuantity = Math.ceil(tier * tier / 2) + 1;
		var rewardBonus = Upgrades.betterMissionRewardUpgrade * 0.05 + 1;
		mQuantity = Std.int(mQuantity * rewardBonus);
	}
	
	public function toString() : String {
		return '$mQuantity monsters';		
	}
	
	override public function take(monsters : Array<Monster>) 
	{
		for (i in 0 ... mQuantity)
			GameManager.getInstance().addMonster();
	}
	
}