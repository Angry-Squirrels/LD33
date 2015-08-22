package;

import neko.Lib;

/**
 * ...
 * @author Thomas BAUDON
 */
class TestMain
{
	
	var mChoiceHandlers : Array<Void -> Void>;

	public static function main() {
		new TestMain();
	}
	
	function new() {
		var game = GameManager.getInstance();
		
		mChoiceHandlers = new Array<Void -> Void>();
		mChoiceHandlers.push(listMissions);
		
		while (true) {
			Lib.println("Que faire ? 1 : voir les missions , 2 : Liste des monstres");
			var choice : Int = Std.parseInt(Sys.stdin().readLine());
			if (choice >= 0 && choice < mChoiceHandlers.length)
				mChoiceHandlers[choice]();
		}
	}
	
	function listMissions() {
		
	}
	
}