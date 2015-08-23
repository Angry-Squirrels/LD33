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
	
	public static function make(level : UInt, coefs : Array<Int> = null) : Stats {
		init();
		var stats = new Stats();
		
		var availablePoints = level * 10;
		
		if (coefs == null) {
			coefs = new Array<Int>();
			var statType = stats.g.length;
			for (i in 0 ... 4) 
				coefs.push(Std.random(5)+1);
		}
		
		while (availablePoints > 0) {
			var statToAsign = Std.random(coefs.length);
			var pointToGive : UInt = coefs[statToAsign];
			if (pointToGive > availablePoints)
				pointToGive = availablePoints;
			availablePoints -= pointToGive;
			stats.g[statToAsign] += pointToGive;
		}
		
		return stats;
	}
	
	public function new() {
		init();
		g = new Array<UInt>();
		for (i in 0 ... statsName.length)
			g.push(0);
	}
	
	public function getLevel() : UInt {
		return Std.int(Math.max(getTotal() / 10, 1.0));
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