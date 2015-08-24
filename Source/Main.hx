package;


import missions.Mission;
import monsters.Monster;
import openfl.display.Sprite;
import ui.Styles;


class Main extends Sprite {
	
	var mGameManager : GameManager;
	
	public function new () {
		
		super ();
		
		new Styles();
		
		mGameManager = GameManager.getInstance();
		mGameManager.addMonster();
		for (i in 0 ... 5) {
			mGameManager.addMonster();
			mGameManager.addMission("Contract");
		}
		addChild(new UIGame(mGameManager));
		
		//mGameManager.startNewDay();
		
	}
	
	
}