package;

import flixel.FlxG;
import flixel.ui.FlxVirtualPad;
import flixel.FlxState;
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
	public static var _gameZoomSave = new FlxSave(); // initialize
	public static var _gameSaveMode = new FlxSave(); // initialize
	public static var zoomVar = 1.0;

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
		_gameZoomSave.bind("zoom");
		_gameSaveMode.bind("controlmode");

        var screenX = FlxG.width;
        var screenY = FlxG.height;


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

		trace('gamezoomsave is ' + _gameZoomSave.data.zoomVar);
		trace('x is ' + _gameZoomSave.data.actionsX);
		trace('y is ' + _gameZoomSave.data.actionsY);
		
		if (screenX == 1136 && screenY == 640) { // SE
			iOSDevice = 1;
		}
		if (screenX == 2436 && screenY == 1125) { // X/XS/iP11
			iOSDevice = 2;
		}
		if ((screenX == 1334 && screenY == 750) || (screenX == 1138 && screenY == 639)) { //6/7/8/SE2
			iOSDevice = 3;
		}
		if ((screenX == 1792 && screenY == 828) || (screenX == 1624 && screenY == 750)) { //XR/11
			iOSDevice = 4;
		}	// da rest lmfao
		if ((screenX == 2688 && screenY == 1242) || (screenX == 2532 && screenY == 1170) || (screenX == 2340 && screenY == 1080) || (screenX == 2788 && screenY == 1284)) { // XS MAX/11 PRO MAX/12/12PRO/12promax/12 mini ???
			iOSDevice = 6;
		}	// ipad
		if (screenY/screenX >= 0.62 && screenY/screenX <= 0.8) {
			iOSDevice = 5;
		}	//safari/desktop
		if (FlxG.width == 1280 && screenY == 720) {
		}
		if ((screenX == 1920 && screenY == 1080) || (screenX == 2208 && screenY == 1242)){
			iOSDevice = 7;
		}

		if (_gameSaveCounter.data.counter == null) {
			// iPhone 5s/SE
			if (iOSDevice == 1) {
				_gameSave.data.dPadX = 300;
				_gameSave.data.dPadY = -155;
				_gameZoomSave.data.zoomVar = 2.0;
				_gameZoomSave.data.actionsX = -300;
				_gameZoomSave.data.actionsY = -155;

				_gameSave.flush(); // save
				_gameZoomSave.flush(); // save
			} 
			// iPhone X
			if (iOSDevice == 2) {
				_gameSave.data.dPadX = 950;
				_gameSave.data.dPadY = -430;
				_gameZoomSave.data.zoomVar = 3.9;
				_gameZoomSave.data.actionsX = -950;
				_gameZoomSave.data.actionsY = -430;

				_gameSave.flush(); // save
				_gameZoomSave.flush(); // save
			}
			// iPhone 6/7/8/SE2 or SE with modded resolution?
			if (iOSDevice == 3) {
				_gameSave.data.dPadX = 400;
				_gameSave.data.dPadY = -220;
				_gameZoomSave.data.zoomVar = 2.35;
				_gameZoomSave.data.actionsX = -400;
				_gameZoomSave.data.actionsY = -220;

				_gameSave.flush(); // save
				_gameZoomSave.flush(); // save
			} 
			// iPhone XR/11
			if (iOSDevice == 4) {
				_gameSave.data.dPadX = 460;
				_gameSave.data.dPadY = -210;
				_gameZoomSave.data.zoomVar = 2.15;
				_gameZoomSave.data.actionsX = -460;
				_gameZoomSave.data.actionsY = -210;

				_gameSave.flush(); // save
				_gameZoomSave.flush(); // save
			}
			// iPhone XS/11 Pro Max/etc
			if (iOSDevice == 6) {
				_gameSave.data.dPadX = 950;
				_gameSave.data.dPadY = -440;
				_gameZoomSave.data.zoomVar = 4.0;
				_gameZoomSave.data.actionsX = -950;
				_gameZoomSave.data.actionsY = -440;

				_gameSave.flush(); // save
				_gameZoomSave.flush(); // save
			}
			// iPads (should cover most if not all ipads??? maybe???????)
			if (iOSDevice == 5) {
				_gameSave.data.dPadX = 650;
				_gameSave.data.dPadY = -490;
				_gameZoomSave.data.zoomVar = 2.6;
				_gameZoomSave.data.actionsX = -650;
				_gameZoomSave.data.actionsY = -490;

				_gameSave.flush(); // save
				_gameZoomSave.flush(); // save
			}

			if (screenX == 1280 && screenY == 720) {
				_gameSave.data.dPadX = 250;
				_gameSave.data.dPadY = -140;
				_gameZoomSave.data.zoomVar = 1.6;
				_gameZoomSave.data.actionsX = -250;
				_gameZoomSave.data.actionsY = -140;

				_gameSave.flush(); // save
				_gameZoomSave.flush(); // save
			}
			
			if (iOSDevice == 7) { // 6+, 7+, 8+
				_gameSave.data.dPadX = 780;
				_gameSave.data.dPadY = -440;
				_gameZoomSave.data.zoomVar = 3.3;
				_gameZoomSave.data.actionsX = -780;
				_gameZoomSave.data.actionsY = -440;

				_gameSave.flush(); // save
				_gameZoomSave.flush(); // save
			}

			_gameSaveMode.data.mode = 0; // dpad as default
			_gameSaveMode.flush(); // save

			_gameSaveCounter.data.counter = 1;
			_gameSaveCounter.flush();
		}

		OptionsMenu.mode = _gameSaveMode.data.mode;
		_pad.dPad.setPosition(_gameSave.data.dPadX, _gameSave.data.dPadY);
		_pad.actions.setPosition(_gameZoomSave.data.actionsX, _gameZoomSave.data.actionsY);
    }
}
