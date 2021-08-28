# SNES snimulator flutter

A new Flutter project.

## Sumary

This project is a simulator for Snes game.

For your reference:

- This project is wrapper of mobile application all based SnesJS (https://github.com/elzo-d/SnesJs)
- This project just make for researching purpose only.

Tested with android simulator blue stack(v5) and ios simulator

## Screen shoots:

<img src="/screen_shoot/ip1.png?raw=true" width="400" height="185" />   <img src="/screen_shoot/ip2.png?raw=true" width="200" height="185" />  

## Technical notes


1. If we want to load a rom just add this widget:

```
SnesMachine.defaultSnes(
            linkToRoom:
                'https://nielsezeka.github.io/data/Super_Mario_World.smc',
          ),
```

where the link https://nielsezeka.github.io/data/Super_Mario_World.smc is your rom(make sure it can be accessible. You can test by go to the link in browser, if it start downloading the *.smc immediately so the link is correct.)


2. To custommize your conntroller
```
SnesMachine(
            leftDpad: SnesLeftPadDefault(), // ---> relace with your custom widget
            rightDpad: SnesRightPadDefault(), // ---> relace with your custom widget
            linkToRoom:
                'https://nielsezeka.github.io/data/Super_Mario_World.smc',
          ),
```
In your custom widget, you can simulate the button click using

Onpress key:

```
SnesController.of(context).controller?.pressKey(
                        key,
                      );
```
Release key

```
SnesController.of(context).controller?.releaseKey(
                        key,
                      );
```

Please note that `pressKey` will release after some short delay to simulate the click, all the buttons (left, right, top, bottom) is not auto release so please to put the var `withAutoRelease` is false for this.   

3. As my mention, this project is wrapper around the snesJS, I try to use `flutter_inappwebview` in order to make it work, so any specific issues / errors you should chek their repo first 


Feel free to use this code, is just want to make some funny code for my researching purpose. If you like it just buy me a coffee :v 