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

typedef MissionDesc = {
	title : String,
	desc : String,
	type : String,
	requires : Array<String>,
	duration : UInt,
	teamSize : UInt,
	rewardType : String,
	statCoef : Array<Int>
};
 
class Mission
{
	
	public var requiredStats : Stats;
	
	public var duration : UInt = 1;
	public var remainingTime : Int;
	public var remainingTimeChanged:Signal1<Int>;
	public var creationDate : UInt;
	public var title : String;
	public var description : String;
	public var reward : Reward;
	public var teamSize : UInt = 1;
	public var type : String;
	public var requires : Array<String>;
	
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
	
	static var mMissionList : Array<MissionDesc>;
	
	static private function initList(){
		if (mListInited) return;
		
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

	public static function get(level : UInt = 1, type : String = "") : Mission {
		if (!mListInited) initList();
		
		var mission = new Mission();
		mission.creationDate = GameManager.getInstance().getDate();
		
		var missionID = Std.random(mMissionList.length);
		if (type != "") {
			var possibleID = find( { type : type } );
			missionID = possibleID[Std.random(possibleID.length)];
		}
		
		var missionDesc = mMissionList[missionID];
		mission.title = missionDesc.title;
		mission.duration = missionDesc.duration;
		mission.description = missionDesc.desc;
		mission.teamSize = missionDesc.teamSize;
		mission.type = missionDesc.type;
		mission.requires = missionDesc.requires;
		mission.requiredStats = Stats.make(level, missionDesc.statCoef);
		
		var rewardClass : Class<Dynamic> = Type.resolveClass("rewards." + missionDesc.rewardType+"Reward");
		mission.reward = Type.createInstance(rewardClass, []);
		mission.reward.computeQuantity(level, mission);
		
		return mission;
	}
	
	public function new() 
	{
		requiredStats = new Stats();
		assignedMonsters = new Array<Monster>();
		assignedMonstersChanged = new Signal0();
		successChanceChanged = new Signal0();
		remainingTimeChanged = new Signal1<Int>();
		
		monsterProgress = new Map<Monster, {before : Array<UInt>, after : Array<UInt>}>();
	}
	
	public function toString() {
		return title + " ; " + description + " stats : " + requiredStats + " requirements : " + requires + " reward : " + reward;
	}
	
	public function onRepportRead() 
	{
		for (monster in assignedMonsters) 
			monster.currentMission = null;
		if(succeed) reward.take(assignedMonsters);
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
		var statRequiredPerMonster = new Array<Float>();
		for (i in 0 ... monster.stats.g.length) 
			statRequiredPerMonster.push(requiredStats.g[i] / assignedMonsters.length);
		
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
		var sumStat = new Array<Int>();
		for (i in 0 ... requiredStats.g.length) 
			sumStat.push(0);
		
		for (monster in assignedMonsters) 
			for(i in 0 ... monster.stats.g.length)
				sumStat[i] += monster.stats.g[i];
			
		var successStat = new Array<Float>();		
		successChance = 0;
		
		for (i in 0 ... requiredStats.g.length){
			successStat.push(sumStat[i] / requiredStats.g[i]);
			if (successStat[i] > 1) successStat[i] = 1;
			successChance += successStat[i];
		}
		
		successChance /= successStat.length;
		
		successChanceChanged.dispatch();
	}
	
	public function areRequirementFilled() : Bool {
		var rep = true;
		for (requirement in requires) {
			var requirementFilled = false;
			for (monster in assignedMonsters) 
				if (monster.traits.indexOf(requirement) != -1)
					requirementFilled = true;
			if (!requirementFilled){
				rep = false;
				break;
			}
		}
		return rep;
	}
	
}