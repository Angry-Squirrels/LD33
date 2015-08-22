package missions;
import monsters.Monster;
import rewards.Reward;
import haxe.Json;
import openfl.Assets;

/**
 * ...
 * @author Thomas BAUDON
 */

typedef MissionType = {
	name : String, 
	statCoef: Array<Float>
};

typedef MissionDesc = {
	title : String,
	desc : String,
	type : String,
	requires : Array<String>,
	duration : UInt,
	teamSize : UInt,
	rewardType : String
};
 
class Mission
{
	
	public var requiredStats : Stats;
	
	public var duration : UInt = 1;
	public var remainingTime : UInt;
	public var creationDate : UInt;
	public var title : String;
	public var description : String;
	public var reward : Reward;
	public var teamSize : UInt = 1;
	
	public var assignedMonsters : Array<Monster>;
	
	static var mJson : Dynamic;
	static var mListInited : Bool;
	
	static var mTypeList : Array<MissionType>;
	static var mMissionList : Array<MissionDesc>;
	
	static private function initList(){
		if (mListInited) return;
		
		mJson = Json.parse(Assets.getText("missions/missions.json"));
		
		mTypeList = mJson.missionsTypes;
		mMissionList = mJson.missions;
		
		mListInited = true;
	}

	public static function get(tier : UInt = 1) : Mission {
		if (!mListInited) initList();
		
		var mission = new Mission();
		mission.creationDate = GameManager.getInstance().getDate();
		
		var missionDesc = mMissionList[Std.random(mMissionList.length)];
		mission.title = missionDesc.title;
		mission.duration = missionDesc.duration;
		mission.description = missionDesc.desc;
		mission.teamSize = missionDesc.teamSize;
		
		var missionType : MissionType = null;
		for (type in mTypeList)
			if (type.name == missionDesc.type)
				missionType = type;
		
		var coefA = missionType.statCoef[Stats.AGILITY];		
		var coefS = missionType.statCoef[Stats.STRENGHT];		
		var coefI = missionType.statCoef[Stats.INTEL];		
		
		mission.requiredStats = Stats.make(tier, coefA, coefS, coefI);
		
		mission.reward = Type.createInstance(Type.resolveClass("rewards." + missionDesc.rewardType+"Reward"), []);
		mission.reward.computeQuantity(tier, mission);
		
		return mission;
	}
	
	public function new() 
	{
		requiredStats = new Stats();
		assignedMonsters = new Array<Monster>();
	}
	
	public function toString() {
		return title + " ; " + description + " stats : " + requiredStats + " award : " + reward;
	}
	
}