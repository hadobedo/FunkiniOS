package;

import flixel.FlxG;
import flixel.addons.transition.FlxTransitionableState;
import flixel.input.gamepad.FlxGamepad;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxCamera;

class GameOverState extends FlxTransitionableState
{
	var bfX:Float = 0;
	var bfY:Float = 0;
	private var camHUD:FlxCamera;

	public function new(x:Float, y:Float)
	{
		super();

		bfX = x;
		bfY = y;
	}

	override function create()
	{

		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		FlxG.cameras.add(camHUD);
		/* var loser:FlxSprite = new FlxSprite(100, 100);
			var loseTex = FlxAtlasFrames.fromSparrow(AssetPaths.lose.png, AssetPaths.lose.xml);
			loser.frames = loseTex;
			loser.animation.addByPrefix('lose', 'lose', 24, false);
			loser.animation.play('lose');
			// add(loser); */

		var bf:Boyfriend = new Boyfriend(bfX, bfY);
		// bf.scrollFactor.set();
		add(bf);
		bf.playAnim('firstDeath');

		FlxG.camera.follow(bf, LOCKON, 0.001);
		/* 
			var restart:FlxSprite = new FlxSprite(500, 50).loadGraphic(AssetPaths.restart.png);
			restart.setGraphicSize(Std.int(restart.width * 0.6));
			restart.updateHitbox();
			restart.alpha = 0;
			restart.antialiasing = true;
			// add(restart); */

		FlxG.sound.music.fadeOut(2, FlxG.sound.music.volume * 0.6);

		// FlxTween.tween(restart, {alpha: 1}, 1, {ease: FlxEase.quartInOut});
		// FlxTween.tween(restart, {y: restart.y + 40}, 7, {ease: FlxEase.quartInOut, type: PINGPONG});

		super.create();

		VirtualPadCamera.VPadCamera();
		add(VirtualPadCamera._pad);
		VirtualPadCamera._pad.cameras = [camHUD];
	}

	override function update(elapsed:Float)
	{
		var pressed:Bool = false;
		var fading:Bool = false;
		
		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		#if mobile
		for (touch in FlxG.touches.list)
			if (touch.justPressed) {
				pressed = true;
				fading = false;
			}
		#end

		if (gamepad != null)
		{
			if (gamepad.justPressed.ANY)
				pressed = true;
		}

		if (pressed && !fading)
		{
			fading = true;
			FlxG.sound.music.fadeOut(0.5, 0, function(twn:FlxTween)
			{
				FlxG.sound.music.stop();
				FlxG.switchState(new PlayState());
			});
		}
		super.update(elapsed);

		switch(VirtualPadCamera.iOSDevice) {
			case 1: // iPhone SE
				camHUD.zoom = 2.0;
			case 2: // iPhone X
				camHUD.zoom = 3.9;
			case 3: // iPhone 6/7/8/SE2
				camHUD.zoom = 2.35;
			case 4: // iPhone XR
				camHUD.zoom = 2.15;
			default: // idk wtf device ur using oops
				camHUD.zoom = 1.0;
		}
	}
}
