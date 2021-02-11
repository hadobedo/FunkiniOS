package;

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
		_pad.alpha = 0.75;
		_pad.loadGraphic('assets/images/virtual-inputfunkin.png', 'assets/images/virtual-inputfunkin.txt');

		// hardcoded control positions eheheheheheheheh
		// this fucking sucks but it works i guess

		// iPhone 5s/SE
		if (screenX == 1136 && screenY == 640) {
			_pad.dPad.setPosition(300, -155);
			_pad.actions.setPosition(-300, -155);
			iOSDevice = 1;
		} 
		// iPhone X
		if (screenX == 2436 && screenY == 1125) {
			_pad.dPad.setPosition(950, -430);
			_pad.actions.setPosition(-950, -430);
			iOSDevice = 2;
		}
		// iPhone 6/7/8/SE2
		if (screenX == 1334 && screenY == 750) {
			_pad.dPad.setPosition(400, -220);
			_pad.actions.setPosition(-400, -220);
			iOSDevice = 3;
		} 
    }
}
