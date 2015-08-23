package rewards;
import missions.Mission;
import monsters.Monster;

/**
 * ...
 * @author Thomas BAUDON
 */
class MissionNumberUpgradeReward extends Reward
{

	public function toString() : String {
		return " more mission slots!";
	}
	
	override public function computeQuantity(tier:UInt, mission:Mission) 
	{
		mQuantity = 10;
	}
	
	override public function take(monsters:Array<Monster>) 
	{
		Upgrades.maxMissionUpgrade++;
	}
	
}