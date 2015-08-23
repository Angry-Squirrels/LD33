package missions;

import monsters.MonsterAvatar;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class MonsterSlot extends Sprite
{
	public var avatar:MonsterAvatar;
	
	public function new() 
	{
		super();
		buttonMode = true;
		
		graphics.lineStyle(2, 0x000000);
		graphics.beginFill(0x000000, 0);
		graphics.drawRect(0, 0, 32, 32);
		
		graphics.lineStyle(4, 0x000000);
		graphics.moveTo(12, 16);
		graphics.lineTo(20, 16);
		graphics.moveTo(16, 12);
		graphics.lineTo(16, 20);
	}
	
	public function setAvatar(monsterAvatar:MonsterAvatar) 
	{
		trace("setAvatar");
		removeAvatar();
		this.avatar = monsterAvatar;
		addChild(monsterAvatar);
	}
	
	public function removeAvatar()
	{
		trace("removeAvatar");
		if (avatar != null && avatar.parent == this) {			
			removeChild(avatar);
		}
		avatar = null;
	}
	
}