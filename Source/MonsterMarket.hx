package;
import monsters.Monster;

/**
 * ...
 * @author Thomas BAUDON
 */
class MonsterMarket
{
	
	public var monsterOnMarket : Array<Monster>;
	public var maxOffers : UInt = 5;
	public var buyValueMultiplier : Float = 2.0;
	
	var mGame : GameManager;
	var offerChangeFreq : UInt = 3;
	var lastOfferTime : UInt = 3;
	
	public function new(game : GameManager) 
	{
		mGame = game;
		monsterOnMarket = new Array<Monster>();
	}
	
	public function sellMonster(monster : Monster) {
		if(monster.currentMission == null){
			if(mGame.monsters.remove(monster)){
				mGame.gold += monster.sellValue;
				mGame.message("Sold " + monster.name + " for $" + monster.sellValue);
				monsterOnMarket.push(monster);
			}
		}
	}
	
	public function buyMonster(monster : Monster) {
		var monsterBuyValue : Int = Std.int(monster.sellValue * buyValueMultiplier);
		if (mGame.gold >= monsterBuyValue &&
			monsterOnMarket.remove(monster)) {
				
			mGame.gold -= monsterBuyValue;
			mGame.monsters.push(monster);
			mGame.message("Bought " + monster.name + " for $" + monsterBuyValue);
		}else
			mGame.message("Not enough muney.");
	}
	
	public function newDay() {
		lastOfferTime++;
		if (lastOfferTime >= offerChangeFreq) {
			changeOffers();
			lastOfferTime = 0;
		}
	}
	
	public function changeOffers() {
		mGame.message("New offers are available in the monster market!");
		monsterOnMarket.splice(0, monsterOnMarket.length);
		
		for (i in 0 ... maxOffers) {
			var monsterTier : Int = mGame.getMonstersTiers() + Std.random(7) - 3;
			if (monsterTier < 1)
				monsterTier = 1;
			monsterOnMarket.push(Monster.get(monsterTier));
		}
	}
	
}