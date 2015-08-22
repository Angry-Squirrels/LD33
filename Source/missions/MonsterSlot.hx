package missions;

import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class MonsterSlot extends Sprite
{

	public function new() 
	{
		super();
		
		graphics.lineStyle(2, 0x000000);
		graphics.drawRect(0, 0, 32, 32);
	}
	
}