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
	var sellDL:DataLine;
	var buyDL:DataLine;
	var rewardsDL:DataLine;
	var missionsDL:DataLine;
	var monstersDL:DataLine;

	
	
	public function new()
	{
		super();
		
		update();
		
		Upgrades.upgradeChanged.add(update);
		
	}
	
	function update()
	{
		currentY = 0;
		while (content.numChildren > 0) content.removeChildAt(0);
		
		monstersDL =addUpgrade("upgrade-monsters", "Max monsters", Upgrades.maxMonsterUpgrade, "", "");
		missionsDL =addUpgrade("upgrade-contracts", "Max contracts", Upgrades.maxMissionUpgrade, "", "");
		rewardsDL =addUpgrade("upgrade-rewards", "Contract rewards", Upgrades.betterMissionRewardUpgrade, "+", "%");
		buyDL =addUpgrade("upgrade-buy", "Buying Prices", Upgrades.betterBuyUpgrade, "-", "%");
		sellDL =addUpgrade("upgrade-sell", "Selling Prices", Upgrades.betterSellUpgrade, "+", "%");
		
		/*Upgrades.betterBuyUpgrade
		Upgrades.betterMissionRewardUpgrade
		Upgrades.betterSellUpgrade
		Upgrades.maxMissionUpgrade*/
		
		
	}
	
	function addUpgrade(asset:String, title:String, value:UInt, pre:String, post:String)
	{
		var container = new Sprite();
		
		var pix = new Bitmap(Assets.getBitmapData("images/" + asset + ".png"));
		pix.alpha = 0.25;
		container.addChild(pix);
		
		var dl = new DataLine(title, pre+(value*5)+post, contentWidth, Styles.BLACK12);
		dl.y = pix.height;
		container.addChild(dl);
		
		container.y = currentY;
		content.addChild(container);
		currentY += container.height + vMargin;
		
		return dl;
		
	}
	
}