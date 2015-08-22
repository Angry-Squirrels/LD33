package missions;

import monsters.Monster;
import monsters.MonsterAvatar;
import openfl.Assets;
import openfl.display.SimpleButton;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import ui.PaperSheet;
import ui.Styles;
import ui.TF;

/**
 * ...
 * @author damrem
 */
class MissionSheet extends PaperSheet
{
	var titleTf:TF;
	var descriptionTf:TF;
	var probBar:ProbabilityBar;
	
	
	
	public function new(mission:Mission, Width:Float=400, Height:Float=480) 
	{
		super(Width, Height);
		
		//var contentWidth = w - 2 * hMargin;
		
		var localVMargin:Float = 16;
		var slotMargin:Float = 8;
		
		titleTf = new TF(mission.title, Styles.BLACK24);
		titleTf.wordWrap = true;
		titleTf.multiline = true;
		titleTf.width = contentWidth;
		
		descriptionTf = new TF(mission.description, Styles.BLACK12);
		descriptionTf.wordWrap = true;
		descriptionTf.multiline = true;
		descriptionTf.width = contentWidth;
		
		var durationLine:DataLine = new DataLine("Duration", mission.duration+" days", contentWidth, Styles.BLACK16);
		var rewardLine:DataLine = new DataLine("Reward", cast(mission.reward), contentWidth, Styles.BLACK16);
		var teamLine:DataLine = new DataLine("Team", "0/" + mission.teamSize+"monster" + ((mission.teamSize > 1)?"s":""), contentWidth, Styles.BLACK16);
		
		var currentSlotX:Float = 0;
		var slotHolder = new Sprite();
		//trace('plop');
		for (i in 0...mission.teamSize) 
		{
			var slot = new MonsterSlot();
			slot.x = currentSlotX;
			currentSlotX += slot.width + slotMargin;
			slotHolder.addChild(slot);
			slot.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent)
			{
				trace('click');
				var monster = Monster.get();
				slot.addAvatar(new MonsterAvatar(monster.picture, 32));
				mission.assignMonster(monster);
			});
		}
		
		mission.successChanceChanged.add(function() {
			trace(mission.successChance);
			probBar.setPercentage(mission.successChance);
		});
		
		var requirementsTf = new TF("Requirement", Styles.BLACK16);
		var brainDL:DataLine = new DataLine("Brain", cast(mission.requiredStats.g[Stats.INTEL]), contentWidth, Styles.BLACK12);
		var agilityDL:DataLine = new DataLine("Agility", cast(mission.requiredStats.g[Stats.AGILITY]), contentWidth, Styles.BLACK12);
		var muscleDL:DataLine = new DataLine("Muscle", cast(mission.requiredStats.g[Stats.STRENGHT]), contentWidth, Styles.BLACK12);
		
		probBar = new ProbabilityBar(contentWidth, 32);
		
		var startButton:StartButton = new StartButton();
		startButton.x = (contentWidth - startButton.width) / 2;
		
		var currentY:Float = vMargin;
		
		titleTf.y = currentY;
		content.addChild(titleTf);
		currentY += titleTf.height;

		descriptionTf.y = currentY;
		content.addChild(descriptionTf);
		currentY += descriptionTf.height;

		currentY += vMargin;
		
		durationLine.y = currentY;
		content.addChild(durationLine);
		currentY += durationLine.height;
		
		rewardLine.y = currentY;
		content.addChild(rewardLine);
		currentY += rewardLine.height;
		
		teamLine.y = currentY;
		content.addChild(teamLine);
		currentY += teamLine.height;
		currentY += slotMargin;
		
		slotHolder.y = currentY;
		content.addChild(slotHolder);
		currentY += slotHolder.height;
		
		currentY += vMargin;
		
		requirementsTf.y = currentY;
		content.addChild(requirementsTf);
		currentY += requirementsTf.height;
		
		brainDL.y = currentY;
		content.addChild(brainDL);
		currentY += brainDL.height;
		
		agilityDL.y = currentY;
		content.addChild(agilityDL);
		currentY += agilityDL.height;
		
		muscleDL.y = currentY;
		content.addChild(muscleDL);
		currentY += muscleDL.height;
		
		currentY += vMargin;
		
		probBar.y = currentY;
		content.addChild(probBar);
		currentY += probBar.height;
		
		currentY += vMargin;
		
		startButton.y = currentY;
		content.addChild(startButton);
		currentY += startButton.height;
		
	}
	
	
	
}