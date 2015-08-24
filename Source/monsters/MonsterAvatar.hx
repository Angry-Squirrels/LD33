package monsters;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.PixelSnapping;
import openfl.display.Sprite;
import ui.RectShape;

/**
 * ...
 * @author damrem
 */
class MonsterAvatar extends Sprite
{
	public var monster:Monster;
	public var card:MonsterCard;
	public function new(monster:Monster, size:Float, fadeOnBusy:Bool=false) 
	{
		super();
		this.monster = monster;
		
		//useHandCursor = true;
		buttonMode = true;
		
		var pic = new Bitmap(monster.picture, PixelSnapping.AUTO, true);
		pic.width = pic.height = size;
		addChild(pic);
		
		var clicker = new RectShape(size, size);
		clicker.alpha = 0.5;
		addChild(clicker);
		
		//width = height = size;
		
		if (fadeOnBusy) {
			monster.currentMissionChanged.add(function(currentMission) {
				if (currentMission == null) alpha = 1;
				else 
				{
					alpha = 0.5;
				}
			});
		}
		
		
		
	}
	
}