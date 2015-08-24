package rewards;
import missions.Mission;
import monsters.Monster;

/**
 * ...
 * @author Thomas BAUDON
 */
class SellUpgradeReward extends Reward
{

	public function toString() : String {
		return "boost your monster value.";
	}
	
	override public function computeQuantity(tier:UInt, mission:Mission) 
	{
		mQuantity = 1;
	}
	
	override public function take(monsters:Array<Monster>) 
	{
		Upgrades.betterSellUpgrade ++;
		Upgrades.upgradeChanged.dispatch();
	}
	
}