package monsters;

import ui.PaperSheet;

/**
 * ...
 * @author damrem
 */
class MonsterListSheet extends PaperSheet
{
	var gameManager:GameManager;

	public function new(gameManager:GameManager, Width:Float=400, Height:Float=480) 
	{
		super(Width, Height);
		this.gameManager = gameManager;
		
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
		
		for (i in 0...monsters.length) {
			var monster = monsters[i];
			var avatar = new MonsterAvatar(monster.picture, avatarSize);
			avatar.x = (i % nbCols) * (avatarSize+avatarMargin);
			avatar.y = Std.int(i / nbCols) * (avatarSize+avatarMargin);
			content.addChild(avatar);
		}
		
	}
	
}