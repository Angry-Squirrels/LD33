package monsters;

/**
 * ...
 * @author Thomas BAUDON
 */
class Traits
{
	
	static var inited : Bool = false;
	static var traits : Array<String>;
	
	public static function getRandomTrait() : String {
		if (!inited) {
			traits = GameManager.getInstance().config.possibleTraits;
			inited = true;
		}
		return traits[Std.random(traits.length)];
	}
	
}