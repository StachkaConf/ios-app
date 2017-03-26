# RectangleDissolve

[![CI Status](http://img.shields.io/travis/Михаил Рахманов/RectangleDissolve.svg?style=flat)](https://travis-ci.org/Михаил Рахманов/RectangleDissolve)
[![Version](https://img.shields.io/cocoapods/v/RectangleDissolve.svg?style=flat)](http://cocoapods.org/pods/RectangleDissolve)
[![License](https://img.shields.io/cocoapods/l/RectangleDissolve.svg?style=flat)](http://cocoapods.org/pods/RectangleDissolve)
[![Platform](https://img.shields.io/cocoapods/p/RectangleDissolve.svg?style=flat)](http://cocoapods.org/pods/RectangleDissolve)

## Description

Screen transition animator which decomposes the screen we are transitioning from into a group of rectangles which fade over time thus showing us the new controller.

![Alt Text](https://github.com/mcrakhman/FilesRepository/blob/master/blackwhitetransition.gif)
![Alt Text](https://github.com/mcrakhman/FilesRepository/blob/master/psychtransition.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```swift
let animator = RectangleDissolveAnimator()
viewController.transitioningDelegate = animator
```

There are also some parameters which can be adjusted: 

```swift
animator.rectanglesVertical = 14 // this determines the height of the rectangle based on screen height
animator.rectanglesHorizontal = 8 // width of the rectangle based on screen width
animator.batchSize = 20 // the amount of rectangles which start fading at the same time
animator.fadeAnimationDuration = 0.3 // fade animation duration
animator.tempo = 1000 // the frequency of each batch start fading
```

## Installation

RectangleDissolve is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "RectangleDissolve"
```
##  

## Author

Михаил Рахманов, rakhmanov.m@gmail.com

## License

RectangleDissolve is available under the MIT license. See the LICENSE file for more info.
