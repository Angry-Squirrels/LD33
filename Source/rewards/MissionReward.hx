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
		var tooMuchMissions = false;
		for (i in 0 ... mQuantity) {
			if(GameManager.getInstance().availableMissions < GameManager.getInstance().maxMissionNb * Upgrades.maxMissionUpgrade)
				GameManager.getInstance().addMission("Contract");
			else
				tooMuchMissions = true;
		}
		if(tooMuchMissions)
			GameManager.getInstance().message("You reached your max pending contract number. You need to upgrade to stock more contract.");
	}
	
	public function toString() : String {
		return '$mQuantity missions.';
	}
	
}