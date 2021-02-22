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

	override public function create()
	{
		super.create();
        }


	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

    public static function VPadCamera() {

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

		// counter is here to only run this on boot as to not conflict with custom set control positions
		// this is a crappy way of doing it i think

		if (counter == 0) {
			// iPhone 5s/SE
			if (screenX == 1136 && screenY == 640) {
				dPadX = 300;
				dPadY = -155;
				actionsX = -300;
				actionsY = dPadY;
				iOSDevice = 1;
			} 
			// iPhone X
			if (screenX == 2436 && screenY == 1125) {
				dPadX = 950;
				dPadY = -430;
				actionsX = -950;
				actionsY = dPadY;
				iOSDevice = 2;
				trace("why, also counter is at " + counter);
			}
			// iPhone 6/7/8/SE2
			if (screenX == 1334 && screenY == 750) {
				dPadX = 400;
				dPadY = -220;
				actionsX = -400;
				actionsY = dPadY;
				iOSDevice = 3;
			} 
			// iPhone XR/11
			if ((screenX == 1792 && screenY == 828) || (screenX == 1624 && screenY == 750)) {
				dPadX = 460;
				dPadY = -210;
				actionsX = -460;
				actionsY = dPadY;
				iOSDevice = 4;
			}
			counter++;
		}
		_pad.dPad.setPosition(dPadX, dPadY);
		_pad.actions.setPosition(actionsX, actionsY);
    }
}
