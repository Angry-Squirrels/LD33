package rewards;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import ui.DataLine;
import ui.PaperSheet;
import ui.Styles;

/**
 * ...
 * @author damrem
 */
class UpgradeSheet extends PaperSheet
{

	public function new(Width:Float=400, Height:Float=480) 
	{
		super(Width, Height);
		
		addUpgrade("upgrade-monsters", "Max monster", Upgrades.maxMonsterUpgrade);
		addUpgrade("upgrade-contracts", "Max contract", Upgrades.maxMonsterUpgrade);
		addUpgrade("upgrade-rewards", "Max monster", Upgrades.maxMonsterUpgrade);
		addUpgrade("upgrade-monsters", "Max monster", Upgrades.maxMonsterUpgrade);
		addUpgrade("upgrade-monsters", "Max monster", Upgrades.maxMonsterUpgrade);
		
		/*Upgrades.betterBuyUpgrade
		Upgrades.betterMissionRewardUpgrade
		Upgrades.betterSellUpgrade
		Upgrades.maxMissionUpgrade*/
		
		
	}
	
	function addUpgrade(asset:String, title:String, value:UInt)
	{
		var container = new Sprite();
		
		var pix = new Bitmap(Assets.getBitmapData("images/" + asset + ".png"));
		container.addChild(pix);
		
		var dl = new DataLine(title, cast(value), contentWidth, Styles.BLACK16);
		dl.y = pix.height;
		container.addChild(dl);
		
		container.y = currentY;
		addChild(container);
		currentY += container.height + vMargin;
		
	}
	
}