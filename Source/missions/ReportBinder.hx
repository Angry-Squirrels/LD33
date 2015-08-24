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
	var gameManager:GameManager;
	var currentMessagePage:MessagePage;
	var messagePages:Array<MessagePage>;
	
	public function new() 
	{
		super("Reports", 320, 448);
		
		gameManager = GameManager.getInstance();
		
		messagePages = new Array<MessagePage>();
		
		var endedTab:Tab = new Tab("Rewards", 304, 344);
		
		endedPile = new SheetPile(304, 344);
		endedTab.addChild(endedPile);
		
		gameManager.endedMissionsChanged.add(updateEnded);
		updateEnded();
		
		addTab(endedTab);
		
		setCurrentTab(endedTab);
	}
	
	public function addMessagePage() {
		var messagePage = new MessagePage(this);
		messagePages.push(messagePage);
		addChild(messagePage);
		messagePage.x = -messagePage.width / 2;
		messagePage.y = -messagePage.height / 2;
		addChild(cover);
	}
	
	public function removeMessagePage() {
		removeChild(messagePages.pop());
		
		
		if (messagePages.length==0 && endedPile.sheets.length == 0)
		{
			close();
		}
	}
	
	function updateEnded() 
	{
		endedPile.empty();
		
		var missions = gameManager.endedMission;
		for (mission in missions) {
			var missionSheet = new EndedMissionSheet(mission);
			endedPile.addSheet(missionSheet);
		}
		if (messagePages.length==0 && endedPile.sheets.length == 0)
		{
			close();
		}
	}
	
	
	
}