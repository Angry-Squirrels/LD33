package;

import haxe.Json;
import lime.Assets;
import neko.Lib;
import sys.io.File;

/**
 * ...
 * @author Thomas BAUDON
 */
class TestMain
{
	
	var mChoiceHandlers : Array<Void -> Void>;
	var mGame : GameManager;
	
	public static function main() {
		new TestMain();
	}
	
	function new() {
		mGame = GameManager.getInstance();
		mGame.startNewDay();
		mGame.addMonster();
		
		mChoiceHandlers = new Array<Void -> Void>();
		mChoiceHandlers.push(listMissions);
		
		while (true) {
			var gold = mGame.gold;
			Lib.println('You have $gold $.');
			Lib.println("What to do ? 1 : List available missions , 2 : List sla... employee.");
			var choice : Int = Std.parseInt(Sys.stdin().readLine());
			choice--;
			if (choice >= 0 && choice < mChoiceHandlers.length)
				mChoiceHandlers[choice]();
		}
	}
	
	function listMissions() {
		Sys.command("CLS");
		Lib.println("-------------------------------------");
		Lib.println("#         AVAILABLE MISSIONS        #");
		Lib.println("-------------------------------------");
		var i = 1;
		for (mission in mGame.availableMissions) {
			Lib.println(i + " : " + mission.title + " ; " + mission.description + " => " + mission.reward);
			i++;
		}
		Lib.println("What mission to do ? 0 back : ");
		var choice : Int = Std.parseInt(Sys.stdin().readLine());
	}
	
}