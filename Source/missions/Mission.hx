package missions;

import monsters.Monster;
import msignal.Signal;
import rewards.Reward;
import haxe.Json;

#if !neko
import openfl.Assets;
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
	public var remainingTime : Int;
	public var creationDate : UInt;
	public var title : String;
	public var description : String;
	public var reward : Reward;
	public var teamSize : UInt = 1;
	public var type : String;
	
	public var successChance : Float = 0;
	public var successChanceChanged:Signal0;
	public var started : Bool = false;
	public var ended : Bool = false;
	public var succeed : Bool = false;
	
	public var monsterProgress : Map<Monster, {before : Array<UInt>, after : Array<UInt>}>;
	
	public var assignedMonsters : Array<Monster>;
	public var assignedMonstersChanged : Signal0;
	
	static var mJson : Dynamic;
	static var mListInited : Bool;
	
	static var mTypeList : Array<MissionType>;
	static var mMissionList : Array<MissionDesc>;
	
	static private function initList(){
		if (mListInited) return;
		
		mTypeList = GameManager.getInstance().config.missionsTypes;
		mMissionList = GameManager.getInstance().config.missions;
		
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
		assignedMonstersChanged = new Signal0();
		successChanceChanged = new Signal0();
		
		monsterProgress = new Map<Monster, {before : Array<UInt>, after : Array<UInt>}>();
	}
	
	public function toString() {
		return title + " ; " + description + " stats : " + requiredStats + " reward : " + reward;
	}
	
	public function onRepportRead() 
	{
		for (monster in assignedMonsters) 
			monster.currentMission = null;
		if(succeed) reward.take();
	}
	
	public function assignMonster(monster : Monster) {
		trace("assignMonster("+monster);
		if (assignedMonsters.length < cast teamSize){
			assignedMonsters.push(monster);
			monster.currentMission = this;
			monster.currentMissionChanged.dispatch(monster.currentMission);
		}
			
		computeSuccess();
		assignedMonstersChanged.dispatch();
	}
	
	public function unassignMonster(monster : Monster) {
		
		trace("unassignMonster(" + monster);
		assignedMonsters.remove(monster);
		monster.currentMission = null;
		monster.currentMissionChanged.dispatch(monster.currentMission);
		
		computeSuccess();
		assignedMonstersChanged.dispatch();
	}
	
	public function end() {
		ended = true;
		var rand = Math.random();
		if (rand <= successChance)
			succeed = true;
		else
			succeed = false;
		
		for (monster in assignedMonsters) {
			
			var beforeXp = new Array<UInt>();
			var afterXp = new Array<UInt>();
			
			for (g in monster.stats.g)
				beforeXp.push(g);
				
			// compute xp gain
			if (succeed)
				giveXP(monster);
			
			for (g in monster.stats.g)
				afterXp.push(g);
				
			var newProgress = {before : beforeXp, after : afterXp};
			
			monsterProgress[monster] = newProgress;
		}
		
		GameManager.getInstance().message("Mission " + title + " ended.");
		
	}
	
	function giveXP(monster : Monster){
		var agiRequiered = requiredStats.g[Stats.AGILITY] / assignedMonsters.length;
		var strRequired = requiredStats.g[Stats.STRENGHT] / assignedMonsters.length;
		var intRequired = requiredStats.g[Stats.INTEL] / assignedMonsters.length;
		
		var statRequiredPerMonster : Array<Float> = [agiRequiered, strRequired, intRequired];
		
		var monsterStats = monster.stats.g;
		for (i in 0 ... monsterStats.length) {
			if (monsterStats[i] >= statRequiredPerMonster[i])
				monsterStats[i] += 1;
			else {
				var diff = statRequiredPerMonster[i] - monsterStats[i];
				var gain = 0.1 * (diff * diff)/2;
				monsterStats[i] += Std.int(gain) + 1;
			}
		}
	}
	
	function computeSuccess():Void 
	{
		var sumAgi = 0;
		var sumStr = 0;
		var sumInt = 0;
		
		for (monster in assignedMonsters) {
			sumAgi += monster.stats.g[Stats.AGILITY];
			sumStr += monster.stats.g[Stats.STRENGHT];
			sumInt += monster.stats.g[Stats.INTEL];
		}
		
		var successA = sumAgi / requiredStats.g[Stats.AGILITY];
		var successS = sumStr / requiredStats.g[Stats.STRENGHT];
		var successI = sumInt / requiredStats.g[Stats.INTEL];
		
		if (successA > 1) successA = 1;
		if (successS > 1) successS = 1;
		if (successI > 1) successI = 1;
		
		successChance = (successA + successS + successI) / 3;
		successChanceChanged.dispatch();
	}
	
}