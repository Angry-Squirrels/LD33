package monsters;
import missions.Mission;
import msignal.Signal.Signal1;
import NameGenerator;
import openfl.Assets;
import openfl.display.BitmapData;


/**
 * ...
 * @author Thomas BAUDON
 */
class Monster
{
	public var currentMission : Mission;
	public var currentMissionChanged:Signal1<Mission>;
	
	public var stats : Stats;
	
	public var traits : Array<String>;
	
	public var name : String;
	public var picture : BitmapData;
	
	public var alive = true;
	
	public var costOfLife(get, null) : Int;
	
	public var sellValue(get, null) : Int;
	public var buyValue(get, null) : Int;
	
	var mCostOfLife : Float = 0;
	var mSellValue : Int = 0;
	var mBuyValue : Int = 0;
	
	public static function get(level : UInt = 1) : Monster {
		var monster = new monsters.Monster();
		monster.name = NameGenerator.getName();
		monster.stats = Stats.make(level);	
		var nbTraitProb = Std.random(100);
		var nbTrait = 0;
		if (nbTraitProb >= 40) nbTrait = 1;
		if (nbTraitProb >= 70) nbTrait = 2;
		if (nbTraitProb >= 88) nbTrait = 3;
		if (nbTraitProb >= 95) nbTrait = 4;
		if (nbTraitProb >= 98) nbTrait = 5;
		for (i in 0 ... nbTrait)
			monster.traits.push(Traits.getRandomTrait());
		monster.mCostOfLife = Math.random()*0.2+0.05;
		
		monster.picture = AvatarGenerator.getAvatar();
		
		
		return monster;
	}

	public function new() 
	{
		stats = new Stats();
		traits = new Array<String>();
		currentMissionChanged = new Signal1<Mission>();
	}
	
	public function toString() : String {
		return name + " stats : " + stats + " traits : " + traits + " dayly cost : " + costOfLife;
	}
	
	function get_costOfLife():UInt 
	{
		return Std.int(sellValue * mCostOfLife);
	}
	
	function get_sellValue():UInt 
	{
		mSellValue = (stats.getTotal() + 3 * traits.length) * 10;
		var priceUpper = Upgrades.betterSellUpgrade * 0.05;
		if (priceUpper > 1)
			priceUpper = 1;
		mSellValue = Std.int(mSellValue * (1 + priceUpper));
		
		return mSellValue;
	}
	
	function get_buyValue():UInt 
	{
		mBuyValue = (stats.getTotal() + 3 * traits.length) * 10 * 2;
		var priceDiscount = Upgrades.betterBuyUpgrade * 0.05;
		if (priceDiscount > 0.8)
			priceDiscount = 0.8;
		mBuyValue = Std.int(mBuyValue * ( 1 - priceDiscount));
		
		if (mBuyValue < sellValue)
			mBuyValue = mSellValue;
			
		return mBuyValue;
	}
	
}