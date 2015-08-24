package rewards;
import missions.Mission;
import monsters.Monster;

/**
 * ...
 * @author Thomas BAUDON
 */
class MonsterNumberUpgradeReward extends Reward
{

	public function toString() : String {
		return " more monsters slots.";
	}
	
	override public function computeQuantity(tier:UInt, mission:Mission) 
	{
		mQuantity = 5;
	}
	
	override public function take(monsters:Array<Monster>) 
	{
		Upgrades.maxMonsterUpgrade++;
		Upgrades.upgradeChanged.dispatch();
	}
	
}