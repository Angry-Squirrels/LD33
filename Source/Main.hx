package;


import missions.Mission;
import monsters.Monster;
import openfl.display.Sprite;
import ui.Styles;


class Main extends Sprite {
	
	
	public function new () {
		
		super ();
		
		new Styles();
		
		for (i in 0 ... 10) {
			trace(Mission.get());
		}
		
		addChild(new UIGame());
		
	}
	
	
}