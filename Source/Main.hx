package;


import missions.Mission;
import monsters.Monster;
import openfl.display.Sprite;


class Main extends Sprite {
	
	
	public function new () {
		
		super ();
		
		for (i in 0 ... 10) {
			trace(Mission.get());
		}
		
	}
	
	
}