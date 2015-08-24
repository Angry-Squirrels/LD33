package missions.sheets;

import missions.Mission;
import monsters.Monster;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import ui.DataLine;
import ui.Styles;
import ui.TextButton;
import ui.TF;

/**
 * ...
 * @author damrem
 */
class EndedMissionSheet extends AbstractMissionSheet
{
	var btn:ui.TextButton;

	public function new(mission:Mission, Width:Float=400, Height:Float=420) 
	{
		super(mission);
		
		draw();
	}
	
	override function draw() {
		super.draw();
		
		var successTf = new TF(mission.succeed?"Success!":"Failure...", Styles.BLACK16);
		successTf.y = currentY;
		currentY += successTf.height;
		content.addChild(successTf);
		
		currentY += vMargin;
		
		if (mission.succeed) {
			
			var rewardDL = new DataLine("Reward", cast(mission.reward), contentWidth, Styles.BLACK16);
			
			rewardDL.y = currentY;
			currentY += rewardDL.height;
			content.addChild(rewardDL);
			
			currentY += vMargin;
			
			//mission.reward
			var xpTf = new TF("Evolution", Styles.BLACK16);
			xpTf.y = currentY;
			
			currentY += xpTf.height+8;
			content.addChild(xpTf);
			
			
			for (monster in mission.assignedMonsters) {
				trace(monster);
				trace(mission.monsterProgress[monster]);
				
				var container = new Sprite();
				var avatar = new Bitmap(monster.picture);
				avatar.width = avatar.height = 32;
				container.addChild(avatar);
				
				var progress = mission.monsterProgress[monster];
				var before = progress.before;
				var after = progress.after;
				
				
				for (i in 0...Stats.statsName.length)
				{
					var dl = new DataLine(Stats.statsName[i], "+" + (after[i] - before[i]), contentWidth - 40, Styles.BLACK12);
					dl.x = 40;
					dl.y = i * 16;
					container.addChild(dl);
				}
				
				content.addChild(container);
				container.y = currentY;
				currentY += container.height + 8;
			}
			
			
			
			
			
			
		}
		
		btn = new TextButton(mission.succeed?"Get that rewards":"F**k those losers");
			btn.x = (contentWidth - btn.width) / 2;
			btn.y = currentY;
			content.addChild(btn);
			currentY += btn.height;
		btn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent) {
				GameManager.getInstance().archiveMission(mission);
			});
	}
	
}