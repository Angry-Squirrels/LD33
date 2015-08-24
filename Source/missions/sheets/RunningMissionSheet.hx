package missions.sheets;
import missions.sheets.AbstractMissionSheet;
import ui.DataLine;
import ui.Styles;

/**
 * ...
 * @author damrem
 */
class RunningMissionSheet extends AbstractMissionSheet
{
	var remainingLine:DataLine;

	public function new(mission:Mission, Width:Float=400, Height:Float=420) 
	{
		super(mission, Width, Height);
		draw();
		
		mission.remainingTimeChanged.add(function(rt:Int) {
			remainingLine.setValue(rt + " days");
		});
	}
	
	override function draw() {
		super.draw();
		
		drawRemainingLine();
		
		drawRewardLine();
		
		drawTeamLineAndSlots();
		
		currentY += vMargin;
		
		updateAvatars();
		
		drawProbBar();
		
		currentY += vMargin;
	}
	
	function drawRemainingLine() 
	{
		remainingLine = new DataLine("Remaining", mission.remainingTime+" days", contentWidth, Styles.BLACK16);
		remainingLine.y = currentY;
		content.addChild(remainingLine);
		currentY += remainingLine.height;
		
		
	}
	
	
	
}