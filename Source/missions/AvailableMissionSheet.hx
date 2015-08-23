package missions;
import monsters.Monster;
import msignal.Signal.Signal0;
import openfl.events.MouseEvent;

/**
 * ...
 * @author damrem
 */
class AvailableMissionSheet extends AbstractMissionSheet
{
	public var monsterRequested:Signal0;
	var startButton:StartButton;
	
	public function new(mission:Mission, Width:Float=400, Height:Float=420) 
	{
		super(mission, Width, Height);
		
		monsterRequested = new Signal0();
		
		mission.successChanceChanged.add(function() {
			trace(mission.successChance);
			probBar.setPercentage(mission.successChance);
		});
		
		mission.assignedMonstersChanged.add(function() {
			
			trace("assignedMonstersChanged");
			
			trace(mission.assignedMonsters);
			
			if (mission.assignedMonsters.length==0) {
				disableStartButton();
			}
			else {
				enableStartButton();
			}
			
			
			updateAvatars();
			
		});
		
		
		draw();
		
	}
	
	override function draw() {
		super.draw();
		
		drawDurationLine("Duration");
		
		drawRewardLine();
		
		drawTeamLineAndSlots();
		
		currentY += vMargin;
		
		for (slot in slots) 
		{
			
			slot.addEventListener(MouseEvent.CLICK, onSlotClicked);
		}
		
		
		drawRequirements();
		
		currentY += vMargin;
		
		drawProbBar();
		
		currentY += vMargin;
		
		drawStartButton();
	}
	
	function drawStartButton() {
		startButton = new StartButton();
		disableStartButton();
		
		startButton.x = (contentWidth - startButton.width) / 2;
		
		startButton.y = currentY;
		content.addChild(startButton);
		currentY += startButton.height;
	}
	
	private function onSlotClicked(evt:MouseEvent):Void 
	{
	
			var slot:MonsterSlot = cast(evt.currentTarget);
			if (slot.avatar==null) {					
				monsterRequested.dispatch();
			}
			else
			{
				mission.unassignMonster(slot.avatar.monster);
			}
			
	}
	
	function launch(evt:MouseEvent = null) {
		trace("launch");
		GameManager.getInstance().launchMission(mission);
			
		disableStartButton();
		
		for (slot in slots) {
			slot.removeEventListener(MouseEvent.CLICK, onSlotClicked);
			slot.buttonMode = false;
		}
	}
	
	function disableStartButton() {
		startButton.removeEventListener(MouseEvent.CLICK, launch);
		startButton.alpha = 0.5;
		startButton.buttonMode = false;
	}
	
	function enableStartButton() {
		startButton.addEventListener(MouseEvent.CLICK, launch);
		startButton.alpha = 1;
		startButton.buttonMode = true;
	}
	
	override public function disactivate() {
		super.disactivate();
		for (monster in mission.assignedMonsters) {
			mission.unassignMonster(monster);
		}
	}
	
	
	public function addMonster(monster:Monster) 
	{
		trace("addMonster");
		var slot:MonsterSlot;
		for (slot in slots)
		{
			if (slot.avatar==null)
			{
				//slot.setAvatar(new MonsterAvatar(monster, 32));
				mission.assignMonster(monster);
				break;
			}
			else
			{
				continue;
			}
		}
	}
	
}