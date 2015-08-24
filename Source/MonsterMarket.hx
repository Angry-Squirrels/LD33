package;
import monsters.Monster;
import msignal.Signal.Signal0;

/**
 * ...
 * @author Thomas BAUDON
 */
class MonsterMarket
{
	
	public var monstersOnMarket : Array<Monster>;
	public var monstersOnMarketChanged:Signal0;
	public var maxOffers : UInt = 5;
	public var buyValueMultiplier : Float = 2.0;
	
	var mGame : GameManager;
	var offerChangeFreq : UInt = 3;
	var lastOfferTime : UInt = 3;
	
	public function new(game : GameManager) 
	{
		mGame = game;
		monstersOnMarket = new Array<Monster>();
		monstersOnMarketChanged = new Signal0();
		monstersOnMarketChanged.dispatch();
	}
	
	public function sellMonster(monster : Monster) {
		if(monster.currentMission == null){
			if (mGame.monsters.remove(monster)) {
				mGame.monstersChanged.dispatch();
				mGame.gold += monster.sellValue;
				mGame.message("Sold " + monster.name + " for $" + monster.sellValue);
				monstersOnMarket.push(monster);
				monstersOnMarketChanged.dispatch();
			}
		}
	}
	
	public function buyMonster(monster : Monster) {
		if (mGame.gold >= monster.buyValue &&
			monstersOnMarket.remove(monster) &&
			mGame.monsters.length < Upgrades.maxMonsterUpgrade * GameManager.maxMonsterNb) {
				
			mGame.gold -= monster.buyValue;
			mGame.monsters.push(monster);
			mGame.monstersChanged.dispatch();
			monstersOnMarketChanged.dispatch();
			mGame.message("Bought " + monster.name + " for $" + monster.buyValue);
		}else if(mGame.gold < monster.buyValue)
			mGame.message("Not enough muney.");
		else
			mGame.message("Not enough space for monster.");
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
		monstersOnMarket.splice(0, monstersOnMarket.length);
		
		for (i in 0 ... maxOffers) {
			var monsterTier : Int = mGame.getMonstersTiers() + Std.random(7) - 3;
			if (monsterTier < 1)
				monsterTier = 1;
			monstersOnMarket.push(Monster.get(monsterTier));
		}
		monstersOnMarketChanged.dispatch();
	}
	
}