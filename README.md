# FunkiniOS, a port of Friday Night Funkin' to iOS Devices (and Safari)

### It's finally ready! This is my native port of Friday Night Funkin' by ninjamuffin99, PhantomArcade and evilsk8r to iOS devices/Safari!

What I've done:
- add scaling for most iOS devices so the game looks and plays well on almost every iOS device. 
- reduced RAM usage by ~70% in some levels by compressing assets and making spritesheets smaller through exporting custom texture atlases based off the .fla file released by PhantomArcade.
- other fixes that probably suck

Install using AltStore or Filza & AppSync if jailbroken.

**If you have an iPad/iPhone 11 or newer, head over to https://hadobedo.github.io/ to try out the mobile version. This is relatively untested but should work, but don't expect stability.**

### HOW TO COMPILE
Check out the original FNF Github page for instructions on how to set up Haxe and Lime right [here](https://github.com/ninjamuffin99/Funkin). 
Once that's all set up, you will need a Mac/Hackintosh (shh) to compile. run `lime test ios` in the main folder, and it should spit out an `ios` folder in the `export\release` folder. Open it, and there should be a `.xcodeproj` file. Open it in xCode, add a `NSBluetoothAlwaysUsageDescription` to the Info.plist and set the string to whatever you want, sign it and deploy!
