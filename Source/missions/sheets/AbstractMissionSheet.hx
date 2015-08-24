package missions.sheets;

import monsters.Monster;
import monsters.MonsterAvatar;
import msignal.Signal;
import msignal.Slot;
import openfl.Assets;
import openfl.display.SimpleButton;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import ui.DataLine;
import ui.PaperSheet;
import ui.Styles;
import ui.TF;

/**
 * ...
 * @author damrem
 */
class AbstractMissionSheet extends PaperSheet
{
	var titleTf:TF;
	var descriptionTf:TF;
	var probBar:ProbabilityBar;
	var slots:Array<MonsterSlot>;
	var mission:Mission;
	
	var slotMargin:Float;
	public var traitsTF:ui.TF;
	
	
	
	
	
	public function new(mission:Mission, Width:Float=304, Height:Float=360) 
	{
		trace("missionSheet");
		super(Width, Height);
		this.mission = mission;
	}
	
	function draw(){
		
		
		slotMargin = 8;
		
		titleTf = new TF(mission.title, Styles.BLACK24);
		titleTf.wordWrap = true;
		titleTf.multiline = true;
		titleTf.width = contentWidth;
		
		descriptionTf = new TF(mission.description, Styles.BLACK12);
		descriptionTf.wordWrap = true;
		descriptionTf.multiline = true;
		descriptionTf.width = contentWidth;
				
		//currentY = vMargin;
		
		titleTf.y = currentY;
		content.addChild(titleTf);
		currentY += titleTf.height;

		descriptionTf.y = currentY;
		content.addChild(descriptionTf);
		currentY += descriptionTf.height;

		currentY += vMargin;
		
		
	}
	
	function drawRewardLine() 
	{
		var rewardLine:DataLine = new DataLine("Reward", cast(mission.reward), contentWidth, Styles.BLACK12);
		rewardLine.y = currentY;
		content.addChild(rewardLine);
		currentY += rewardLine.height;
		
	}
	
	function drawDurationLine(label:String) 
	{
		var durationLine:DataLine = new DataLine(label, mission.duration+" days", contentWidth, Styles.BLACK12);
		durationLine.y = currentY;
		content.addChild(durationLine);
		currentY += durationLine.height;
		
		
	}
	
	function drawTeamLineAndSlots() 
	{
		var teamLine:DataLine = new DataLine("Team", mission.teamSize+" monster" + ((mission.teamSize > 1)?"s":""), contentWidth, Styles.BLACK12);
		teamLine.y = currentY;
		content.addChild(teamLine);
		currentY += teamLine.height;
		currentY += slotMargin;
		
		
		
		var currentSlotX:Float = 0;
		slots = new Array<MonsterSlot>();
		var slotHolder = new Sprite();
		//trace('plop');
		for (i in 0...mission.teamSize) 
		{
			var slot = new MonsterSlot();
			slots.push(slot);
			slot.x = currentSlotX;
			currentSlotX += slot.width + slotMargin;
			slotHolder.addChild(slot);
		}
		slotHolder.y = currentY;
		content.addChild(slotHolder);
		currentY += slotHolder.height;
	}
	
	function drawProbBar() 
	{
		probBar = new ProbabilityBar(contentWidth, 32);
		probBar.setPercentage(mission.successChance);
		
		probBar.y = currentY;
		content.addChild(probBar);
		currentY += probBar.height;
	}
	
	function drawRequirements() 
	{
		var requirementsTf = new TF("Requirements", Styles.BLACK16);
				
		requirementsTf.y = currentY;
		content.addChild(requirementsTf);
		currentY += requirementsTf.height;

		for (i in 0 ... Stats.statsName.length) {
			var statDL : DataLine = new DataLine(Stats.statsName[i], cast(mission.requiredStats.g[i]), contentWidth, Styles.BLACK12);
			statDL.y = currentY;
			content.addChild(statDL);
			currentY += statDL.height;
		}
		if (mission.requires.length > 0) {
			traitsTF = new TF("+ "+mission.requires.toString(), Styles.BLACK12);
			traitsTF.width = contentWidth;
			traitsTF.y = currentY;
			content.addChild(traitsTF);
			currentY += traitsTF.height;
		}
	}
	
	function updateAvatars() 
	{
		for (i in 0...slots.length) {
			trace("slot");
			var slot = slots[i];
			slot.removeAvatar();
			if (mission.assignedMonsters[i] != null)
			{
				var monster = mission.assignedMonsters[i];
				slot.setAvatar(new MonsterAvatar(mission.assignedMonsters[i], 32));
			}
			
		}
	}
	
	
	
	
	
	
	
	
	
	
	
}

