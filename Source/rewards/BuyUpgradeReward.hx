package rewards;
import missions.Mission;
import monsters.Monster;

/**
 * ...
 * @author Thomas BAUDON
 */
class BuyUpgradeReward extends Reward
{

	public function toString() : String {
		return "reduce monster buy price.";
	}
	
	override public function computeQuantity(tier:UInt, mission:Mission){
		mQuantity = 1;
	}
	
	override public function take(monsters:Array<Monster>) 
	{
		Upgrades.betterBuyUpgrade++;
		Upgrades.upgradeChanged.dispatch();
	}
	
}