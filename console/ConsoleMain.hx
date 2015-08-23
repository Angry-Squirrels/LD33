package;

import haxe.Json;
import lime.Assets;
import missions.Mission;
import monsters.Monster;
import neko.Lib;
import sys.io.File;

/**
 * ...
 * @author Thomas BAUDON
 */
class ConsoleMain
{
	
	
	var mGame : GameManager;
	var mCurrentMission : Mission;
	
	public static function main() {
		new ConsoleMain();
	}
	
	function new() {
		mGame = GameManager.getInstance();
		mGame.startNewDay();
		
		var choiceHandlers : Array<Dynamic> = [
			listMissions,
			listMonster,
			listOnGoingMission,
			listEndedMission,
			goToMarket,
			endTheDay
		];
		
		while (true) {
			var gold = mGame.gold;
			Lib.println('You have $gold $.');
			Lib.println("What to do ? \n " + 
						"1 : List available missions \n " +
						"2 : List sla... employee \n " +
						"3 : List on going missions \n " +
						"4 : List ended missions \n " +
						"5 : Go to the market \n " +
						"6 : End the day \n ");
			var choice : Int = Std.parseInt(Sys.stdin().readLine());
			choice--;
			if (choice >= 0 && choice < choiceHandlers.length)
				choiceHandlers[choice]();
		}
	}
	
	function listMissions() {
		Sys.command("CLS");
		Lib.println("-------------------------------------");
		Lib.println("#         AVAILABLE MISSIONS        #");
		Lib.println("-------------------------------------");
		var i = 0;
		for (mission in mGame.availableMissions) {
			i++;
			Lib.println(i + " : " + mission);
		}
		Lib.println("What mission to do ? 0 back : ");
		var choice : Int = Std.parseInt(Sys.stdin().readLine());
		if (choice > 0 && choice <= i) {
			var mission = mGame.availableMissions[choice - 1];
			mCurrentMission = mission;
			mission.successChanceChanged.add(onMissionSuccessChanceChanged);
			for (a in 0 ... mission.teamSize) {
				var monster = listMonster();
				if (monster == null)
					break;
				else
					mission.assignMonster(monster);
			}
			mission.successChanceChanged.removeAll();
			mGame.launchMission(mission);
		}
		mCurrentMission = null;
	}
	
	function endTheDay() {
		mGame.endDay();
	}
	
	function listOnGoingMission() {
		Sys.command("CLS");
		Lib.println("-------------------------------------");
		Lib.println("#         ON GOING MISSIONS         #");
		Lib.println("-------------------------------------");
		var i = 0;
		for (mission in mGame.ongoingMissions) {
			i++;
			Lib.println(i + " : " + mission.title + " remaining : " + mission.remainingTime + " days");
		}
		Lib.println("Enter to go back");
		var rep = Sys.stdin().readLine();
	}
	
	function listEndedMission() {
		Sys.command("CLS");
		Lib.println("-------------------------------------");
		Lib.println("#           ENDED MISSIONS          #");
		Lib.println("-------------------------------------");
		var i = 0;
		for (mission in mGame.endedMission) {
			i++;
			Lib.println(i + " : " + mission);
		}
		Lib.println("What repport to read ? 0 : back");
		var choice : Int = Std.parseInt(Sys.stdin().readLine());
		if (choice > 0 && choice <= i) 
			readRepport(mGame.endedMission[choice - 1]);
	}
	
	function readRepport(mission : Mission) {
		Sys.command("CLS");
		Lib.println("-------------------------------------");
		Lib.println("#              REPPORT              #");
		Lib.println("-------------------------------------");
		Lib.println("Mission : " + mission.title);
		Lib.println(mission.description);
		if(mission.succeed){
			Lib.println("Success !");
			Lib.println("Reward : " + mission.reward);
		}
		else
			Lib.println("Fail !");
		for (monster in mission.assignedMonsters) {
			Lib.println(monster.name);
			Lib.println("\t agi " 	+ mission.monsterProgress[monster].before[Stats.AGILITY] + 
						" --> " 	+ mission.monsterProgress[monster].after[Stats.AGILITY]);
			Lib.println("\t str " 	+ mission.monsterProgress[monster].before[Stats.STRENGHT] + 
						" --> " 	+ mission.monsterProgress[monster].after[Stats.STRENGHT]);
			Lib.println("\t int " 	+ mission.monsterProgress[monster].before[Stats.INTEL] + 
						" --> " 	+ mission.monsterProgress[monster].after[Stats.INTEL]);
		}
		Lib.println("Enter to go back.");
		var rep = Sys.stdin().readLine();
		mGame.archiveMission(mission);
	}
	
	function listMonster() : Monster{
		Sys.command("CLS");
		Lib.println("-------------------------------------");
		Lib.println("#         AVAILABLE MONSTERS        #");
		Lib.println("-------------------------------------");
		var i = 0;
		var availble = new Array<Monster>();
		for (monster in mGame.monsters) {
			if (monster.currentMission == null){
				i++;
				Lib.println(i + " : " + monster);
				availble.push(monster);
			}
		}
		if (mCurrentMission == null) return null;
		Lib.println("What monster should be assigned to this mission ? 0 back : ");
		var choice : Int = Std.parseInt(Sys.stdin().readLine());
		if (choice > 0 && choice <= i) 
			return availble[choice - 1];
		return null;
		
	}
	
	function goToMarket() {
		Sys.command("CLS");
		Lib.println("-------------------------------------");
		Lib.println("#           MONSTER MARKET          #");
		Lib.println("-------------------------------------");
		Lib.println("What to do ? \n 0: back \n 1: buy monsters \n 2: sell monsters \n ");
		var choice : Int = Std.parseInt(Sys.stdin().readLine());
		if (choice > 0 && choice <= 2) 
			if (choice == 1)
				buyMonster();
			else if (choice == 2)
				sellMonster();
	}
	
	function onMissionSuccessChanceChanged() {
		mGame.message("Mission success chance : " + Std.int(mCurrentMission.successChance * 100) + "%");
	}
	
	function buyMonster() {
		Sys.command("CLS");
		Lib.println("-------------------------------------");
		Lib.println("#           MONSTER MARKET          #");
		Lib.println("-------------------------------------");
		Lib.println("  Today offers : ");
		var i = 0 ;
		for (monster in mGame.market.monsterOnMarket) {
			i++;
			Lib.println("\t"+i+": " + monster + " cost : $" + monster.sellValue * mGame.market.buyValueMultiplier);
		}
		var choice = Std.parseInt(Sys.stdin().readLine());
		if (choice > 0 && choice <= i)
			mGame.market.buyMonster(mGame.market.monsterOnMarket[choice - 1]);
	}
	
	function sellMonster() {
		Sys.command("CLS");
		Lib.println("-------------------------------------");
		Lib.println("#           MONSTER MARKET          #");
		Lib.println("-------------------------------------");
		Lib.println("  What monster do you have to sell ?");
		var i = 0 ;
		var freeMonsters = mGame.getFreeMonster();
		for (monster in freeMonsters) {
			i++;
			Lib.println("\t"+i+": " + monster + " cost : $" + monster.sellValue);
		}
		var choice = Std.parseInt(Sys.stdin().readLine());
		if (choice > 0 && choice <= i)
			mGame.market.sellMonster(freeMonsters[choice - 1]);
	}
	
}