package monsters;

import openfl.display.Sprite;
import openfl.events.MouseEvent;
import ui.DataLine;
import ui.PaperObject;
import ui.PostIt;
import ui.Styles;
import ui.TextButton;
import ui.TF;

/**
 * ...
 * @author damrem
 */
class MonsterCard extends PostIt
{

	public function new(monster:Monster, isBuying:Bool=false, pickMode:Bool=false) 
	{
		super(320, 320, 16, 16);
		
		var identity = new Sprite();
		
		var avatar = new MonsterAvatar(monster, 64);
		identity.addChild(avatar);
		
		var nameTf = new TF(monster.name, Styles.BLACK16);
		nameTf.x = avatar.width + 8;
		nameTf.multiline = nameTf.wordWrap = true;
		nameTf.width = contentWidth - avatar.width - 8;
		
		var levelDL = new DataLine("Lvl", cast(monster.stats.getLevel()), nameTf.width, Styles.BLACK16);
		levelDL.x = nameTf.x;
		levelDL.y = nameTf.height;
		identity.addChild(levelDL);
		
		identity.addChild(nameTf);
		
		content.addChild(identity);
		
		
		currentY += identity.height;
		
		
		currentY += 8;
		
		
		for (i in 0...Stats.statsName.length)
		{
			var statLine = new DataLine(Stats.statsName[i], cast(monster.stats.g[i]), contentWidth, Styles.BLACK12);
			statLine.y = currentY;
			content.addChild(statLine);
			currentY += statLine.height;
		}
		
		currentY += vMargin;
		
		var price = isBuying?monster.buyValue:monster.sellValue;
		
		var priceDL = new DataLine("Sell Price", cast(price), contentWidth, Styles.BLACK12);
		priceDL.y = currentY;
		
		
		if ( !pickMode)
		{
			if (!isBuying)
			{
				if (monster.currentMission == null)
				{
					content.addChild(priceDL);
					currentY += priceDL.height;
					
					currentY += 8;
					
					var sellButton = new TextButton("Sell that morron");
					sellButton.x = (contentWidth-sellButton.width) / 2+4;
					sellButton.y = currentY;
					content.addChild(sellButton);
					
					
					sellButton.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent)
					{
						GameManager.getInstance().market.sellMonster(monster);
					});
				}
			}
			else
			{
				content.addChild(priceDL);
				currentY += priceDL.height;
		
				currentY += 8;
		
				var buyButton = new TextButton("Buy that vermin");
				buyButton.x = (contentWidth-buyButton.width) / 2+4;
				buyButton.y = currentY;
				content.addChild(buyButton);
				if (GameManager.getInstance().gold < monster.buyValue)
				{
					buyButton.disable();
				}
				else
				{
					buyButton.enable();
				}
				
				
				buyButton.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent)
				{
					GameManager.getInstance().market.buyMonster(monster);
				});
				
			}
		}
	}
	
}

