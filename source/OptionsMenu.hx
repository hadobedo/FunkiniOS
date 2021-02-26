package;

import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.FlxCamera;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;

class OptionsMenu extends MusicBeatState
{
	// i kinda jacked this menu to serve as a place to adjust flxvirtualpad positions, whoops

	private var camHUD:FlxCamera;
	private var camGame:FlxCamera;

	private var padxPos = new FlxText(0, 0, 32);
	private var padyPos = new FlxText(0, 0, 32);
	private var rightButton:FlxButton;	// dpad move right
	private var leftButton:FlxButton; // dpad move left
	private var upButton:FlxButton; // dpad move up
	private var downButton:FlxButton; // dpad move down

	private var rightButtonAction:FlxButton;	// action move right
	private var leftButtonAction:FlxButton; // action move left
	private var upButtonAction:FlxButton; // action move up
	private var downButtonAction:FlxButton; // action move down

	private var alphaButtonUp:FlxButton; // alpha button up
	private var alphaButtonDown:FlxButton; // alpha button down

	var optionsText:FlxText;
	var alphaText:FlxText;


	override function create()
	{
		optionsText = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
		optionsText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		optionsText.alpha = 0.7;

		alphaText = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
		alphaText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		alphaText.alpha = 0.7;

		camHUD = new FlxCamera();
		camGame = new FlxCamera();
		camHUD.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD);

		FlxCamera.defaultCameras = [camGame];

		var menuBG:FlxSprite = new FlxSprite().loadGraphic('assets/images/menuDesat.png');
		menuBG.color = 0xFFea71fd;
		if (FlxG.width == 2436 && FlxG.height == 1125) {
			menuBG.setGraphicSize(2436, 1327);
		} else {
			menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		}
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		super.create();

		// there is probably a much, much better way of doing this
		// but if it works ¯\_(ツ)_/¯ lolol

		rightButton = new FlxButton(FlxG.width/1.65, FlxG.height/2.75, function() {
			VirtualPadCamera._gameSave.data.dPadX += 10;

			VirtualPadCamera._gameSave.flush();

			VirtualPadCamera._pad.dPad.setPosition(VirtualPadCamera._gameSave.data.dPadX, VirtualPadCamera._gameSave.data.dPadY);
		});
		rightButton.loadGraphic('assets/images/custompad/rightarrow.png', true, 44, 41);
		rightButton.cameras = [camGame];
		add(rightButton);

		leftButton = new FlxButton(FlxG.width/1.75, FlxG.height/2.75, function() {
			VirtualPadCamera._gameSave.data.dPadX -= 10;

			VirtualPadCamera._gameSave.flush();

			VirtualPadCamera._pad.dPad.setPosition(VirtualPadCamera._gameSave.data.dPadX, VirtualPadCamera._gameSave.data.dPadY);
		});
		leftButton.loadGraphic('assets/images/custompad/leftarrow.png', true, 44, 41);
		leftButton.cameras = [camGame];
		add(leftButton);

		upButton = new FlxButton(FlxG.width/1.7, FlxG.height/3, function() {
			VirtualPadCamera._gameSave.data.dPadY -= 10;

			VirtualPadCamera._gameSave.flush();

			VirtualPadCamera._pad.dPad.setPosition(VirtualPadCamera._gameSave.data.dPadX, VirtualPadCamera._gameSave.data.dPadY);
		});
		upButton.loadGraphic('assets/images/custompad/uparrow.png', true, 44, 41);
		upButton.cameras = [camGame];
		add(upButton);

		downButton = new FlxButton(FlxG.width/1.7, FlxG.height/2.5, function() {
			VirtualPadCamera._gameSave.data.dPadY += 10;
			trace('gamesave dPadY = ' + VirtualPadCamera._gameSave.data.dPadY);
			trace('actual dPadY = ' + VirtualPadCamera.dPadY);
			VirtualPadCamera._gameSave.flush();

			VirtualPadCamera._pad.dPad.setPosition(VirtualPadCamera._gameSave.data.dPadX, VirtualPadCamera._gameSave.data.dPadY);
		});
		downButton.loadGraphic('assets/images/custompad/downarrow.png', true, 44, 41);
		downButton.cameras = [camGame];
		add(downButton);


		alphaButtonUp = new FlxButton(FlxG.width/1.7, FlxG.height/2.1, function() {
			VirtualPadCamera.padAlpha = VirtualPadCamera.padAlpha + 0.05;
			VirtualPadCamera._pad.alpha = VirtualPadCamera.padAlpha;
		});
		alphaButtonUp.loadGraphic('assets/images/custompad/uparrow.png', true, 44, 41);
		alphaButtonUp.cameras = [camGame];
		add(alphaButtonUp);

		alphaButtonDown = new FlxButton(FlxG.width/1.7, FlxG.height/1.9, function() {
			VirtualPadCamera.padAlpha = VirtualPadCamera.padAlpha - 0.05;
			VirtualPadCamera._pad.alpha = VirtualPadCamera.padAlpha;
		});
		alphaButtonDown.loadGraphic('assets/images/custompad/downarrow.png', true, 44, 41);
		alphaButtonDown.cameras = [camGame];
		add(alphaButtonDown);

		VirtualPadCamera.VPadCamera();
		add(VirtualPadCamera._pad);
		VirtualPadCamera._pad.cameras = [camHUD];
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		optionsText.cameras = [camGame];
		optionsText.text = ('DPAD POSITION:');
		add(optionsText);
		optionsText.setPosition(FlxG.width/2.3, FlxG.height/2.75);

		alphaText.cameras = [camGame];
		alphaText.text = ('BUTTON ALPHA:');
		add(alphaText);
		alphaText.setPosition(FlxG.width/2.3, FlxG.height/2);

		switch(VirtualPadCamera.iOSDevice) {
			case 1: // iPhone SE
				camHUD.zoom = 2.0;
			case 2: // iPhone X
				camHUD.zoom = 3.9;
				camGame.zoom = 2.5;
			case 3: // iPhone 6/7/8/SE2
				camHUD.zoom = 2.35;
			case 4: // iPhone XR
				camHUD.zoom = 2.15;	
			default: // idk wtf device ur using oops
				camHUD.zoom = 1.0;
		}

		var BACK = VirtualPadCamera._pad.buttonB.justPressed;

		if (BACK)
			{
				FlxG.switchState(new MainMenuState());
			}
	}
}
