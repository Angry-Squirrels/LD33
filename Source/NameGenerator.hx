package;

/**
 * ...
 * @author Thomas BAUDON
 */
class NameGenerator
{
	
	static var mAdjectiveList : Array<String>;
	static var mNameList : Array<String>;

	static var mInited : Bool = false;
	
	static function init() {
		if (mInited) return;
		
		mAdjectiveList = [
			"Vaillant", 
			"Happy", 
			"Grumpy", 
			"Brave", 
			"Epic", 
			"Floppy", 
			"Jealous",
			"Plumber",
			"Farmer",
			"Tomatoe",
			"Potatoe",
			"Desertic",
			"Galactic",
			"3 Legged ",
			"One Eye",
			"3 Eye-",
			"Silent",
			"Killer",
			"Thief",
			"White",
			"Black",
			"Green",
			"Pinky",
			"Punky"
			
		];
		mNameList = [
			"Bob", 
			"Jerry", 
			"John", 
			"Johnny", 
			"Harry", 
			"Larry", 
			"Terry", 
			"Frodo", 
			"Pukachi",
			"Joe",
			"Frank",
			"Bill",
			"Mike",
			"José",
			"Marco",
			"Tom",
			"Thomas",
			"Freddy",
			"Dona",
			"Kelly",
			"Kim",
			"Kimberly",
			"Sarah",
			"Jonas",
			"Mario",
			"Luigi",
			"Woody",
			"Morris",
			"Jim",
			"Harrison",
			"Luke",
			"Walt",
			"Walter",
			"Donny",
			"Rebecca",
			"Divine",
			"Mary",
			"Giuseppe",
			"Maria",
			"Pinky",
			"Rex",
			"Roxane"
		];
		
		mInited = true;
	}
	
	static public function getName() : String {
		if (!mInited) init();
		
		return mAdjectiveList[Std.random(mAdjectiveList.length)] + " " + mNameList[Std.random(mNameList.length)];
	}
	
}