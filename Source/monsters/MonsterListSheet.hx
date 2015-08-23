package monsters;

import msignal.Signal.Signal1;
import openfl.events.MouseEvent;
import ui.PaperSheet;

/**
 * ...
 * @author damrem
 */
class MonsterListSheet extends PaperSheet
{
	public var pickMode:Bool;
	public var monsterPicked:Signal1<Monster>;
	var gameManager:GameManager;
	var avatars:Array<MonsterAvatar>;//WARNING: if we can sell monsters, remove monster from here

	public function new(Width:Float=400, Height:Float=480) 
	{
		super(Width, Height);
		this.gameManager = GameManager.getInstance();
		
		monsterPicked = new Signal1<Monster>();
		
		gameManager.addMonster();
		gameManager.addMonster();
		gameManager.addMonster();
		gameManager.addMonster();
		gameManager.addMonster();
		gameManager.addMonster();
		gameManager.addMonster();
		gameManager.addMonster();
		gameManager.addMonster();
		
		
		var monsters = gameManager.monsters;
		var avatarSize = 64;
		var avatarMargin = 8;
		
		var nbMonsters = monsters.length;
		var nbCols = Std.int(Width / (avatarSize+avatarMargin));
		
		avatars = new Array<MonsterAvatar>();
		
		for (i in 0...monsters.length) {
			
			var monster:Monster = monsters[i];
			
			var avatar = new MonsterAvatar(monster, avatarSize, true);
			avatars.push(avatar);
			avatar.x = (i % nbCols) * (avatarSize+avatarMargin);
			avatar.y = Std.int(i / nbCols) * (avatarSize+avatarMargin);
			content.addChild(avatar);
			
			avatar.alpha = monster.currentMission != null?0.5:1;
			//avatar.alpha = 0.5;
			
			avatar.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent) {
				
				trace(pickMode);
				trace(monster.currentMission);
				if (pickMode && monster.currentMission == null) {
					trace("pickMode & available monster");
					monsterPicked.dispatch(monster);
				}
			});
			
			avatar.addEventListener(MouseEvent.MOUSE_OVER, function(evt:MouseEvent) {
				
				if (avatar.card == null) {
					avatar.card = new MonsterCard(monster);
				}
				avatar.card.x = evt.localX;
				avatar.card.y = evt.localY;
				addChild(avatar.card);
			});
			
			//avatar.addEventListener(MouseEvent.MOUSE_OUT, hideCard)
		}
		
	}
	
	function update() {
		
	}
	
}