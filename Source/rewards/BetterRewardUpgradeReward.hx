package rewards;
import missions.Mission;
import monsters.Monster;

/**
 * ...
 * @author Thomas BAUDON
 */
class BetterRewardUpgradeReward extends Reward
{

	public function toString() {
		return "better rewards.";
	}
	
	override public function computeQuantity(tier:UInt, mission:Mission) 
	{
		mQuantity = 1;
	}
	
	override public function take(monsters:Array<Monster>) 
	{
		Upgrades.betterMissionRewardUpgrade++;
		Upgrades.upgradeChanged.dispatch();
	}
	
}