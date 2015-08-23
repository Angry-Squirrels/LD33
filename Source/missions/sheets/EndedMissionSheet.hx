package missions.sheets;

import missions.Mission;

/**
 * ...
 * @author damrem
 */
class EndedMissionSheet extends AbstractMissionSheet
{

	public function new(mission:Mission, Width:Float=400, Height:Float=420) 
	{
		super(mission, Width, Height);
		super.draw();
	}
	
}