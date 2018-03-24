package;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;

/**
 * ...
 * @author ninjaMuffin
 */
class SettingState extends FlxState
{
	public static var masterVol:Float = 1;
	public static var musicVol:Float = 1;
	public static var soundVol:Float = 1;
	public static var moanVol:Float = 1;
	//public static var Mode:Bool = false
	public static var gameSpeed:Float = 1;
	
	private var musicTxt:FlxText;
	private var speedTxt:FlxText;
	
	/**
	 * First array is is title
	 * second array is value
	 * third is lowest possible value
	 */
	private var settingsArray:Array<Dynamic> = 
	[
		["Mater Volume", "Music Volume", "SFX Volume", "Moan Volume", "Game Speed"], 
		[masterVol, musicVol, soundVol, moanVol, gameSpeed],
		[0, 0, 0, 0, 0.1]
	];
	
	private var _selection:Int = 0;
	private var _selector:FlxSpriteGroup;
	private var _selLeft:FlxText;
	private var _selRight:FlxText;
	
	private var _grpValues:FlxTypedGroup<FlxText>;
	
	override public function create():Void 
	{
		_selector = new FlxSpriteGroup();
		add(_selector);
		
		_grpValues = new FlxTypedGroup<FlxText>();
		add(_grpValues);
		
		_selLeft = new FlxText(0, 0, 0, "<", 32);
		_selector.add(_selLeft);
		
		_selRight = new FlxText(100, 0, 0, ">", 32);
		_selector.add(_selRight);
		
		for (i in 0...settingsArray[0].length)
		{
			var yPos:Float = (34 * i) + 100;
			
			var settingText:FlxText = new FlxText(32, yPos, 0, settingsArray[0][i], 32);
			add(settingText);
			
			var settingValue:FlxText = new FlxText(FlxG.width - 96, yPos, 0, Std.string(settingsArray[1][i]), 32);
			_grpValues.add(settingValue);
		}
		
		
		_selector.x = FlxG.width - 130;
		changePos();
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		//speedTxt.text = "Game Speed: " + gameSpeed;
		
		controls();
		
		if (_selection > settingsArray[0].length - 1)
			_selection = 0;
		if (_selection < 0)
			_selection = Std.int(settingsArray[0].length - 1);
		
		if (FlxG.keys.justPressed.ANY)
			changePos();
		
		
		if (FlxG.keys.justPressed.ENTER)
		{
			FlxG.switchState(new MenuState());
		}
		
		for (t in 0..._grpValues.members.length)
		{
			_grpValues.members[t].text = Std.string(settingsArray[1][t]); 
		}
		
	}
	
	private function controls():Void
	{
		
		if (FlxG.keys.justPressed.W)
		{
			_selection -= 1;
			changePos();
		}
		else if (FlxG.keys.justPressed.S)
		{
			_selection += 1;
			changePos();
		}
		
		
		if (FlxG.keys.justPressed.A)
		{
			changeValue(-0.1);
		}
		if (FlxG.keys.justPressed.D)
		{
			changeValue(0.1);
		}
	}
	
	private function changeValue(diff:Float):Void
	{
		settingsArray[1][_selection] += diff;
		
		if (settingsArray[1][_selection] < settingsArray[2][_selection])
			settingsArray[1][_selection] = settingsArray[2][_selection];
		
		settingsArray[1][_selection] = FlxMath.roundDecimal(settingsArray[1][_selection], 1);
		
		masterVol = settingsArray[1][0]
		musicVol = settingsArray[1][1];
		soundVol = settingsArray[1][2];
		moanVol = settingsArray[1][3];
		gameSpeed = settingsArray[1][4];
		
	}

	private function changePos():Void
	{
		_selector.y = (_selection * 34) + 34 * 3;
	}
	
}