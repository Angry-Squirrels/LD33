package missions;
import missions.sheets.ArchivedMissionSheet;
import missions.sheets.EndedMissionSheet;
import ui.Binder;
import ui.SheetPile;
import ui.Tab;

/**
 * ...
 * @author damrem
 */
class ReportBinder extends Binder
{
	public var endedPile:SheetPile;
	public var archivedPile:SheetPile;
	
	var gameManager:GameManager;
	var currentMessagePage:MessagePage;
	
	public function new() 
	{
		super("Reports", 320, 448);
		
		gameManager = GameManager.getInstance();
		
		var endedTab:Tab = new Tab("Rewards", 304, 344);
		
		endedPile = new SheetPile(304, 344);
		//endedPile.y = 32;
		endedTab.addChild(endedPile);
		
		gameManager.endedMissionsChanged.add(updateEnded);
		updateEnded();
		
		addTab(endedTab);
		
		setCurrentTab(endedTab);
	}
	
	public function addMessagePage() {
		currentMessagePage = new MessagePage(this);
		addChild(currentMessagePage);
		currentMessagePage.x = -currentMessagePage.width / 2;
		currentMessagePage.y = -currentMessagePage.height / 2;
		addChild(cover);
	}
	
	public function removeMessagePage() {
		removeChild(currentMessagePage);
	}
	
	function updateEnded() 
	{
		endedPile.empty();
		
		var missions = gameManager.endedMission;
		for (mission in missions) {
			var missionSheet = new EndedMissionSheet(mission);
			endedPile.addSheet(missionSheet);
		}
	}
	
	function updateArchived() {
		
		archivedPile.empty();
		
		var missions = gameManager.archivedMissions;
		for(mission in missions)
		{
			var missionSheet = new ArchivedMissionSheet(mission);
			archivedPile.addSheet(missionSheet);
		}
	}
	
}