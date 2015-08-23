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
		mGameManager.startNewDay();
		mGameManager.addMonster();
		
		addChild(new UIGame(mGameManager));
		
	}
	
	
}