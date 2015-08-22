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
		
		mAdjectiveList = ["Vaillant", "Happy", "Grumpy", "Brave", "Epic", "Floppy", "Jealous"];
		mNameList = ["Bob", "Jerry", "Jhon", "Larry", "Terry", "Frodo", "Pukachi"];
		
		mInited = true;
	}
	
	static public function getName() : String {
		if (!mInited) init();
		
		return mAdjectiveList[Std.random(mAdjectiveList.length)] + " " + mNameList[Std.random(mNameList.length)];
	}
	
}