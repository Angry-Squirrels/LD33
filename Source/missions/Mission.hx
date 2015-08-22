package missions;
import monsters.Monster;
import openfl.desktop.ClipboardTransferMode;
import rewards.Reward;
import haxe.Json;
import openfl.Assets;

#if neko
import sys.io.File;
#end

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
	public var type : String;
	
	public var assignedMonsters : Array<Monster>;
	
	static var mJson : Dynamic;
	static var mListInited : Bool;
	
	static var mTypeList : Array<MissionType>;
	static var mMissionList : Array<MissionDesc>;
	
	static private function initList(){
		if (mListInited) return;
		
		var rawText : String = "";
		#if neko
		rawText = File.getContent("Assets/missions/missions.json");
		#else
		rawText = Assets.getText("missions/missions.json");
		#end
		mJson = Json.parse(rawText);
		
		mTypeList = mJson.missionsTypes;
		mMissionList = mJson.missions;
		
		mListInited = true;
	}
	
	public static function find(fields : Dynamic) : Array<UInt> {
		var rep = new Array<UInt>();
		var id = 0;
		for (mission in mMissionList) {
			var push = true;
			for (field in Reflect.fields(fields)) 
				if (!Reflect.hasField(mission, field)) {
					push = false;	
					break;
				}else if (Reflect.field(mission, field) != Reflect.field(fields, field)){
					push = false;	
					break;
				}
			
			if(push)
				rep.push(id);
			id++;
		}
		
		return rep;
	}

	public static function get(tier : UInt = 1, type : String = "") : Mission {
		if (!mListInited) initList();
		
		var mission = new Mission();
		mission.creationDate = GameManager.getInstance().getDate();
		
		var missionID = Std.random(mMissionList.length);
		if (type != "") {
			var possibleID = find( { type : "Capture" } );
			missionID = possibleID[Std.random(possibleID.length)];
		}
		
		var missionDesc = mMissionList[missionID];
		mission.title = missionDesc.title;
		mission.duration = missionDesc.duration;
		mission.description = missionDesc.desc;
		mission.teamSize = missionDesc.teamSize;
		mission.type = missionDesc.type;
		
		var missionType : MissionType = null;
		for (type in mTypeList)
			if (type.name == missionDesc.type)
				missionType = type;
		
		var coefA = missionType.statCoef[Stats.AGILITY];		
		var coefS = missionType.statCoef[Stats.STRENGHT];		
		var coefI = missionType.statCoef[Stats.INTEL];		
		
		mission.requiredStats = Stats.make(tier, coefA, coefS, coefI);
		
		var rewardClass : Class<Dynamic> = Type.resolveClass("rewards." + missionDesc.rewardType+"Reward");
		mission.reward = Type.createInstance(rewardClass, []);
		mission.reward.computeQuantity(tier, mission);
		
		return mission;
	}
	
	public function new() 
	{
		requiredStats = new Stats();
		assignedMonsters = new Array<Monster>();
	}
	
	public function toString() {
		return title + " ; " + description + " stats : " + requiredStats + " reward : " + reward;
	}
	
}