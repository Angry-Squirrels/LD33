package monsters;

import msignal.Signal.Signal1;
import openfl.events.MouseEvent;
import ui.PaperSheet;

/**
 * ...
 * @author damrem
 */
class MarketSheet extends PaperSheet
{
	var gameManager:GameManager;
	var avatars:Array<MonsterAvatar>;//WARNING: if we can sell monsters, remove monster from here

	public function new() 
	{
		super(304, 360);
		this.gameManager = GameManager.getInstance();
		
		gameManager.market.monstersOnMarketChanged.add(update);
		
		update();
	}
	
	function update()
	{
		while (content.numChildren>0) content.removeChildAt(0);
		
		var monsters = gameManager.market.monstersOnMarket;
		var avatarSize = 64;
		var avatarMargin = 8;
		
		var nbMonsters = monsters.length;
		var nbCols = Std.int(w / (avatarSize+avatarMargin));
		
		avatars = new Array<MonsterAvatar>();
		
		for (i in 0...monsters.length) {
			
			var monster:Monster = monsters[i];
			
			var avatar = new MonsterAvatar(monster, avatarSize, true);
			avatar.rotation = Math.random() * 10 - 5;
			avatars.push(avatar);
			avatar.x = (i % nbCols) * (avatarSize+avatarMargin);
			avatar.y = Std.int(i / nbCols) * (avatarSize+avatarMargin);
			content.addChild(avatar);
			
			avatar.alpha = monster.currentMission != null?0.5:1;
			//avatar.alpha = 0.5;
			
			avatar.addEventListener(MouseEvent.ROLL_OVER, function(evt:MouseEvent) {
				trace("mouseover");
				content.addChild(avatar);
				//avatar.mouseChildren = true;
				if (avatar.card == null) {
					avatar.card = new MonsterCard(monster, true);
				}
				avatar.card.x = avatar.width/3;
				avatar.card.y = avatar.height / 3;
				avatar.card.rotation = Math.random() * 10 - 5;
				avatar.addChild(avatar.card);
			});
			
			avatar.addEventListener(MouseEvent.ROLL_OVER, function(evt:MouseEvent) {
				trace("rollover");
			});
			
			avatar.addEventListener(MouseEvent.ROLL_OUT, function(evt:MouseEvent) {
				if (avatar.card != null && avatar.card.parent == avatar)
				{
					avatar.removeChild(avatar.card);
				}
			});
			//avatar.addEventListener(MouseEvent.MOUSE_OUT, hideCard)
		}
		
	}
	

	
}