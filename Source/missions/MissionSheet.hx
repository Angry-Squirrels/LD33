package missions;

import openfl.Assets;
import openfl.display.SimpleButton;
import openfl.display.Sprite;
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
	
	
	
	public function new(mission:Mission) 
	{
		super(400, 480);
		
		var contentWidth = w - 2 * hMargin;
		
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
		for (i in 0...mission.teamSize) 
		{
			var slot = new MonsterSlot();
			slot.x = currentSlotX;
			currentSlotX += slot.width + slotMargin;
			slotHolder.addChild(slot);
		}
		
		var requirementsTf = new TF("Requirement", Styles.BLACK16);
		var brainDL:DataLine = new DataLine("Brain", cast(mission.requiredStats.g[Stats.INTEL]), contentWidth, Styles.BLACK12);
		var agilityDL:DataLine = new DataLine("Agility", cast(mission.requiredStats.g[Stats.AGILITY]), contentWidth, Styles.BLACK12);
		var muscleDL:DataLine = new DataLine("Muscle", cast(mission.requiredStats.g[Stats.STRENGHT]), contentWidth, Styles.BLACK12);
		
		var probBar:ProbabilityBar = new ProbabilityBar(contentWidth, 32);
		
		var startButton:StartButton = new StartButton();
		startButton.x = (contentWidth - startButton.width) / 2;
		
		var currentY:Float = vMargin;
		
		titleTf.y = currentY;
		addChild(titleTf);
		currentY += titleTf.height;

		descriptionTf.y = currentY;
		addChild(descriptionTf);
		currentY += descriptionTf.height;

		currentY += vMargin;
		
		durationLine.y = currentY;
		addChild(durationLine);
		currentY += durationLine.height;
		
		rewardLine.y = currentY;
		addChild(rewardLine);
		currentY += rewardLine.height;
		
		teamLine.y = currentY;
		addChild(teamLine);
		currentY += teamLine.height;
		currentY += slotMargin;
		
		slotHolder.y = currentY;
		addChild(slotHolder);
		currentY += slotHolder.height;
		
		currentY += vMargin;
		
		requirementsTf.y = currentY;
		addChild(requirementsTf);
		currentY += requirementsTf.height;
		
		brainDL.y = currentY;
		addChild(brainDL);
		currentY += brainDL.height;
		
		agilityDL.y = currentY;
		addChild(agilityDL);
		currentY += agilityDL.height;
		
		muscleDL.y = currentY;
		addChild(muscleDL);
		currentY += muscleDL.height;
		
		currentY += vMargin;
		
		probBar.y = currentY;
		addChild(probBar);
		currentY += probBar.height;
		
		currentY += vMargin;
		
		startButton.y = currentY;
		addChild(startButton);
		currentY += startButton.height;
		
	}
	
	
	
}