package monsters;

/**
 * ...
 * @author Thomas BAUDON
 */
class Traits
{
	
	static var traits = ["ugly", "tentacles", "none"];
	
	public static function getRandomTrait() : String {
		return traits[Std.random(traits.length)];
	}
	
}