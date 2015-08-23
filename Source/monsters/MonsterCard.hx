package monsters;

import openfl.events.MouseEvent;
import ui.DataLine;
import ui.PaperObject;
import ui.Styles;
import ui.TextButton;

/**
 * ...
 * @author damrem
 */
class MonsterCard extends PaperObject
{

	public function new(monster:Monster, Width:Float=256, Height:Float=256, hMargin:Float=16, vMargin:Float=16) 
	{
		super(Width, Height, hMargin, vMargin);
		
		
		
		for (i in 0...Stats.statsName.length)
		{
			var statLine = new DataLine(Stats.statsName[i], cast(monster.stats.g[i]), contentWidth, Styles.BLACK12);
			statLine.y = currentY;
			addChild(statLine);
			currentY += statLine.height;
		}
		
		currentY += vMargin;
		
		var sellButton = new TextButton("Sell that morron");
		sellButton.y = currentY;
		addChild(sellButton);
		
		sellButton.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent)
		{
			GameManager.getInstance().market.sellMonster(monster);
		});
	}
	
}