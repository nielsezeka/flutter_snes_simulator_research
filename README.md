# SNES snimulator flutter

A new Flutter project.

## Sumary

This project is a simulator for Snes game.

For your reference:

- This project is wrapper of mobile application all based SnesJS (https://github.com/elzo-d/SnesJs)
- This project just make for researching purpose only.

Tested with android simulator blue stack(v5)

## Technical notes


1. If we want to load a rom just add this widget:

```
SnesJSWidget(
    urlOfGame: 'https://nielsezeka.github.io/data/Super_Mario_World.smc',
)
```

where the link https://nielsezeka.github.io/data/Super_Mario_World.smc is your rom(make sure it can be accessible. You can test by go to the link in browser, if it start downloading the *.smc immediately so the link is correct.)


2. As my mention, this project is wrapper around the snesJS, I try to use `flutter_inappwebview` in order to make it work, so any specific issues / errors you should chek their repo first 


Feel free to use this code, is just want to make some funny code for my researching purpose. If you like it just buy me a coffee :v 