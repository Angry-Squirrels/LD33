package monsters;

import msignal.Signal.Signal1;
import openfl.events.MouseEvent;
import ui.PaperSheet;
import ui.Styles;
import ui.TF;

/**
 * ...
 * @author damrem
 */
class MonsterListSheet extends PaperSheet
{
	public var pickMode(get, set):Bool;
	var _pickMode:Bool;
	public var pickModeChanged:Signal1<Bool>;
	public var monsterPicked:Signal1<Monster>;
	var gameManager:GameManager;
	var avatars:Array<MonsterAvatar>;//WARNING: if we can sell monsters, remove monster from here

	public function new() 
	{
		super(304, 360);
		this.gameManager = GameManager.getInstance();
		
		pickModeChanged = new Signal1<Bool>();
		
		monsterPicked = new Signal1<Monster>();
		
		gameManager.monstersChanged.add(update);
		gameManager.ongoingMissionsChanged.add(update);
		gameManager.endedMissionsChanged.add(update);
		
		update();
	}
	
	public function update()
	{
		while (content.numChildren > 0) content.removeChildAt(0);
		
		currentY = 0;
		
		var monsters = gameManager.monsters;
		var avatarSize = 64;
		var avatarMargin = 8;
		
		var nbMonsters = monsters.length;
		var nbCols = Std.int(w / (avatarSize+avatarMargin));
		
		avatars = new Array<MonsterAvatar>();
		
		if (monsters.length == 0)
		{
			var tf = new TF("No monster, dude.", Styles.BLACK16);
			tf.y = currentY;
			content.addChild(tf);
			currentY += tf.height + vMargin;
		}
		else if (pickMode)
		{
			var tf = new TF("Pick-a-Monster:", Styles.BLACK16);
			tf.y = currentY;
			content.addChild(tf);
			currentY += tf.height + vMargin;
		}
		
		
		var _monsters:Array<Monster> = monsters.copy();
		if (pickMode)
		{
			_monsters = monsters.filter(function(monster):Bool
			{
				return monster.currentMission == null;
			});
		}
		
		for (i in 0..._monsters.length) {
			
			var monster:Monster = _monsters[i];
			if (pickMode && monster.currentMission != null)
			{
				continue;
			}
			
			var avatar = new MonsterAvatar(monster, avatarSize, true);
			avatar.rotation = Math.random() * 2 - 1;
			avatars.push(avatar);
			avatar.x = (i % nbCols) * (avatarSize+avatarMargin);
			avatar.y = currentY + Std.int(i / nbCols) * (avatarSize+avatarMargin);
			content.addChild(avatar);
			
			trace("CURRENT MISSION="+monster.currentMission);
			avatar.alpha = (monster.currentMission != null)?0.5:1;
			//avatar.alpha = 0.5;
			
			avatar.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent) {
				
				trace(pickMode);
				trace(monster.currentMission);
				if (pickMode && monster.currentMission == null) {
					trace("pickMode & available monster");
					monsterPicked.dispatch(monster);
				}
			});
			
			avatar.addEventListener(MouseEvent.ROLL_OVER, function(evt:MouseEvent) {
				trace("mouseover");
				content.addChild(avatar);
				//avatar.mouseChildren = true;
				if (avatar.card == null) {
					avatar.card = new MonsterCard(monster, false, pickMode);
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
	
	public function cancelPicking()
	{
		pickMode = false;
		update();
		visible = true;
	}
	
	function get_pickMode():Bool 
	{
		return _pickMode;
	}
	
	function set_pickMode(value:Bool):Bool 
	{
		pickModeChanged.dispatch(value);
		return _pickMode = value;
	}
	
	
	

	
}