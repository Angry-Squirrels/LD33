package;

/**
 * ...
 * @author Thomas BAUDON
 */
class Stats
{

	public static inline var AGILITY = 0;
	public static inline var STRENGHT = 1;
	public static inline var INTEL = 2;
	
	public var g : Array<UInt>;
	
	public static function make(tier : UInt, coefA : Float = -1, coefS : Float = -1, coefI : Float = -1) : Stats {
		var stats = new Stats();
		
		if(coefA == -1 && coefS == -1 && coefI == -1){
			var statType = Std.random(3);
			switch(statType) {
				case AGILITY :
					coefA = 2;
					coefS = 1;
					coefI = 1;
				case STRENGHT :
					coefS = 2;
					coefA = 1;
					coefI = 1;
				case INTEL :
					coefI = 2;
					coefA = 1;
					coefS = 1;
			}
		}
		
		for (i in 0 ... stats.g.length) 
			stats.g[i] = Std.random(5) * tier;
			
		stats.g[AGILITY] = Std.int(stats.g[AGILITY] * coefA);
		stats.g[STRENGHT] = Std.int(stats.g[STRENGHT] * coefS);
		stats.g[INTEL] = Std.int(stats.g[INTEL] * coefI);
		
		stats.g[AGILITY] ++;
		stats.g[STRENGHT] ++;
		stats.g[INTEL] ++;
		
		return stats;
	}
	
	public function new() {
		g = [0, 0, 0];
	}
	
	public function getTier() : UInt {
		var bestStat = g[0];
		for (stat in g)
			if (stat > bestStat)
				bestStat = stat;
			
		var tier = Math.ceil(bestStat / 10);
		return tier;
	}
	
	public function toString() : String {
		return "{A : " + g[Stats.AGILITY] + " S : " + g[Stats.STRENGHT] + " I : " + g[Stats.INTEL] + " tier : " + getTier() + "}";
	}
	
}