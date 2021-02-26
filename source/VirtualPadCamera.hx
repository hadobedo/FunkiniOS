package;

import flixel.system.FlxAssets.GraphicVirtualInput;
import lime.graphics.Image;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.ui.FlxVirtualPad;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.graphics.frames.FlxAtlasFrames;
import PlayState.PlayState;
import flixel.util.FlxSave;

class VirtualPadCamera extends FlxState
{
    public static var _pad:FlxVirtualPad;
	public static var iOSDevice:Int;
	public static var dPadX = FlxG.width/2; // fallback?
	public static var dPadY = -(FlxG.height/2); // fallback?
	public static var actionsX = -(FlxG.width/2); // fallback?
	public static var actionsY = -(FlxG.height/2); // fallback?)
	public static var counter = 0;
	public static var padAlpha = 0.75;
	public static var _gameSave = new FlxSave(); // initialize
	public static var _gameSaveCounter = new FlxSave(); // initialize

	override public function create()
	{
		super.create();
        }


	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

    public static function VPadCamera() {

		_gameSave.bind("DPadPos"); // bind to the named save slot
		_gameSaveCounter.bind("counter");

        var screenX = openfl.system.Capabilities.screenResolutionX;
        var screenY = openfl.system.Capabilities.screenResolutionY;


		_pad = new FlxVirtualPad(FULL, A_B);
		_pad.alpha = padAlpha;
		// custom button images lookin gangsta
		_pad.buttonUp.loadGraphic('assets/images/custompad/uparrow.png', true, 44, 41);
		_pad.buttonDown.loadGraphic('assets/images/custompad/downarrow.png', true, 44, 41);
		_pad.buttonLeft.loadGraphic('assets/images/custompad/leftarrow.png', true, 44, 41);
		_pad.buttonRight.loadGraphic('assets/images/custompad/rightarrow.png', true, 44, 41);

		_pad.buttonA.loadGraphic('assets/images/custompad/abutton.png', true, 44, 41);
		_pad.buttonB.loadGraphic('assets/images/custompad/bbutton.png', true, 44, 41);

		// hardcoded control positions eheheheheheheheh
		// this fucking sucks but it works i guess

		// counter is here to only run this on first time boot as to not conflict with custom set control positions
		// this is a crappy way of doing it i think

		trace(_gameSaveCounter.data.counter);

		if (_gameSaveCounter.data.counter == null) {
			// iPhone 5s/SE
			if (screenX == 1136 && screenY == 640) {
				_gameSave.data.dPadX = 300;
				_gameSave.data.dPadY = -155;

				_gameSave.flush(); // save
			} 
			// iPhone X
			if (screenX == 2436 && screenY == 1125) {
				_gameSave.data.dPadX = 950;
				_gameSave.data.dPadY = -430;

				_gameSave.flush(); // save
			}
			// iPhone 6/7/8/SE2
			if (screenX == 1334 && screenY == 750) {
				_gameSave.data.dPadX = 400;
				_gameSave.data.dPadY = -220;

				_gameSave.flush(); // save
			} 
			// iPhone XR/11
			if ((screenX == 1792 && screenY == 828) || (screenX == 1624 && screenY == 750)) {
				_gameSave.data.dPadX = 460;
				_gameSave.data.dPadY = -210;

				_gameSave.flush(); // save
			}
			_gameSaveCounter.data.counter = 1;
			_gameSaveCounter.flush();
		}

		if (screenX == 1136 && screenY == 640) {
			actionsX = -300;
			actionsY = -155;
			iOSDevice = 1;
		}
		if (screenX == 2436 && screenY == 1125) {
			actionsX = -950;
			actionsY = -430;
			iOSDevice = 2;
		}
		if (screenX == 1334 && screenY == 750) {
			actionsX = -400;
			actionsY = -220;
			iOSDevice = 3;
		}
		if ((screenX == 1792 && screenY == 828) || (screenX == 1624 && screenY == 750)) {
			actionsX = -460;
			actionsY = -210;
			iOSDevice = 4;
		}
		_pad.dPad.setPosition(_gameSave.data.dPadX, _gameSave.data.dPadY);
		_pad.actions.setPosition(actionsX, actionsY);
    }
}
