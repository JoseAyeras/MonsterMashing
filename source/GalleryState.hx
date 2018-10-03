package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.ui.FlxSpriteButton;

/**
 * ...
 * @author 
 */
class GalleryState extends FlxState 
{
	// SYNTAX GUIDE
	// link to image
	// Info
	// isAnimated
	// frames horiz num
	// frames vert num
	// animation data
	private var grid:Array<Dynamic> = 
	[
		[
			"assets/images/edition.png",
			"Test Info"
		],
		[
			"assets/images/left_and_right.png",
			"more info",
			true,
			2,
			1,
			[
				[
					"idle",
					[0, 1],
					6
				]
			]
		],
		[
			"assets/images/mmLogo.png",
			"logo thing"
		],
		[
			"assets/images/preloaderArt.png",
			"Coolguy PhantomArcade, at the Ambler Theater before the Newgrounds Pico Day Reanimated event from Oct twenty something"
		],
		[
			"assets/images/spr_player.png",
			"The Player sprites"
		],
		[
			"assets/images/trimmedAndFixedSprites.png",
			"All the enemy sprites"
		]
	];

	private var bigImage:FlxSpriteGroup;
	private var _grpThumbnails:FlxTypedGroup<FlxSpriteButton>;
	private var bigPreview:FlxSprite;
	
	override public function create():Void 
	{
		FlxG.mouse.visible = true;
		
		bigImage = new FlxSpriteGroup();
		bigPreview = new FlxSprite();
		bigImage.add(bigPreview);
		
		var imageText:FlxText = new FlxText(0, FlxG.height - 70, FlxG.width - 6, "Test Words", 18);
		imageText.alignment = FlxTextAlign.CENTER;
		imageText.screenCenter(X);
		bigImage.add(imageText);
		
		var text:FlxText = new FlxText(10, 10, 0, "Gallery", 16);
		add(text);
		
		_grpThumbnails = new FlxTypedGroup<FlxSpriteButton>();
		add(_grpThumbnails);
		
		for (i in 0...grid.length)
		{
			var gridPos:FlxPoint = new FlxPoint(120 * (i % 4) + 10, (120 * Std.int(i / 4)) + 60);
			
			var gridBG:FlxSpriteButton = new FlxSpriteButton(gridPos.x, gridPos.y, null, function(){
				bigImage.visible = true;
				bigPreview.loadGraphic(grid[i][0]);
				
				var isAnimated = false;
				var horizSize:Int = Std.int(bigPreview.width);
				var vertSize:Int = Std.int(bigPreview.height);
				// checks if animated
				if (grid[i][2] == true)
				{
					isAnimated = true;
					horizSize = Std.int(horizSize / grid[i][3]);
					vertSize = Std.int(vertSize / grid[i][4]);
				}
				
				bigPreview.loadGraphic(grid[i][0], isAnimated, horizSize, vertSize);
				
				// loads animation data
				if (grid[i][2] == true)
				{
					for (a in 0...grid[i][5].length)
					{
						bigPreview.animation.add(grid[i][5][a][0], grid[i][5][a][1], grid[i][5][a][2]);
						bigPreview.animation.play(grid[i][5][a][0]);
					}
				}
				
				if (bigPreview.width > bigPreview.height)
					bigPreview.setGraphicSize(Std.int(FlxG.width * 0.8));
				else
					bigPreview.setGraphicSize(0, Std.int(FlxG.height * 0.8));
				
				bigPreview.updateHitbox();
				bigPreview.screenCenter();
				
				imageText.text = grid[i][1];
				
			});
			gridBG.makeGraphic(100, 100);
			_grpThumbnails.add(gridBG);
			
			var gridThing:FlxSprite = new FlxSprite(gridPos.x, gridPos.y);
			gridThing.loadGraphic(grid[i][0]);
			
			var testSize:Int = 90;
			if (gridThing.width > gridThing.height)
				gridThing.setGraphicSize(testSize);
			else
				gridThing.setGraphicSize(0, testSize);
			
			gridThing.updateHitbox();
			gridThing.setPosition(gridBG.getMidpoint().x - (gridThing.width / 2), gridBG.getMidpoint().y - (gridThing.height / 2)); 
			add(gridThing);
		}
		
		add(bigImage);
		bigImage.visible = false;
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (FlxG.mouse.wheel != 0)
		{
			bigPreview.setGraphicSize(Std.int(bigPreview.width + (FlxG.mouse.wheel * 10)));
			bigPreview.updateHitbox();
			bigPreview.screenCenter();
		}
		
		
		// REPLACE THESE TO BE CLEANER LATER AND WITH MORE KEYS
		if (FlxG.keys.pressed.S)
		{
			bigPreview.offset.y += 10;
		}
		if (FlxG.keys.pressed.W)
		{
			bigPreview.offset.y -= 10;
		}
		
		if (FlxG.keys.pressed.D)
		{
			bigPreview.offset.x += 10;
		}
		
		if (FlxG.keys.pressed.A)
		{
			bigPreview.offset.x -= 10;
		}
		
		
		
		
		super.update(elapsed);
	}
	
}