package missions;

/**
 * ...
 * @author damrem
 */
class RunningMissionSheet extends AbstractMissionSheet
{

	public function new(mission:Mission, Width:Float=400, Height:Float=420) 
	{
		super(mission, Width, Height);
		draw();
	}
	
	override function draw() {
		super.draw();
		
		drawDurationLine("Remaining");
		
		drawRewardLine();
		
		drawTeamLineAndSlots();
		
		currentY += vMargin;
		
		updateAvatars();
		
		drawProbBar();
		
		currentY += vMargin;
	}
	
}