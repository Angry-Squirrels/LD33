package monsters;
import missions.Mission;
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
	
	public var stats : Stats;
	
	public var traits : Array<String>;
	
	public var name : String;
	public var picture : BitmapData;
	
	public var costOfLife(get, null) : UInt;
	
	public var sellValue(get, null) : UInt;
	
	var mCostOfLife : Float = 0;
	var mSellValue : UInt = 0;
	
	public static function get(tier : UInt = 1) : Monster {
		var monster = new monsters.Monster();
		monster.name = NameGenerator.getName();
		monster.stats = Stats.make(tier);	
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
		
		monster.picture = Assets.getBitmapData("images/monster.png");
		
		return monster;
	}

	public function new() 
	{
		stats = new Stats();
		traits = new Array<String>();
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
		return mSellValue;
	}
	
}