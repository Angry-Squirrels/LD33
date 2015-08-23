package;

/**
 * ...
 * @author Thomas BAUDON
 */
class Stats
{

	public static var statsName : Array<String>;
	static var inited = false;
	
	public var g : Array<UInt>;
	
	public static function init() {
		if (!inited) {
			inited = true;
			statsName = GameManager.getInstance().config.statsNames;
		}	
	}
	
	public static function make(tier : UInt, coefs : Array<Float> = null) : Stats {
		init();
		var stats = new Stats();
		
		if (coefs == null) {
			coefs = new Array<Float>();
			var statType = stats.g.length;
			for (i in 0 ... 4) 
				if (i + 1 == statType)
					coefs.push(2.0);
				else
					coefs.push(1.0);
		}
		
		for (i in 0 ... stats.g.length) 
			stats.g[i] = Std.int(Std.random(5) * tier * coefs[i] + 1);
		
		return stats;
	}
	
	public function new() {
		init();
		g = new Array<UInt>();
		for (i in 0 ... statsName.length)
			g.push(0);
	}
	
	public function getLevel() : UInt {
		var bestStat = g[0];
		for (stat in g)
			if (stat > bestStat)
				bestStat = stat;
			
		var level = Math.ceil(bestStat / 10);
		return level;
	}
	
	public function toString() : String {
		var rep = "[";
		var i = 0;
		for (name in statsName){
			rep += name + ": " + g[i];
			i++;
			if (i < statsName.length)
				rep += ", ";
			else
				rep += "]";
		}
		rep += ", level: " + getLevel();
		return rep;
	}
	
	public function getTotal() : UInt {
		var sum = 0;
		for ( i in 0 ... g.length)
			sum += g[i];
		return sum;
	}
	
}