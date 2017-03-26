//
//  TempoCounter.swift
//  GithubItunesViewer
//
//  Created by MIKHAIL RAKHMANOV on 12.02.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

import Foundation
import QuartzCore

enum BeatStep: Int {
    case fourth = 4
    case eighth = 8
    case sixteenth = 16
    case thirtyTwo = 32
}

typealias Handler = () -> ()

class TempoCounter {
    fileprivate var displayLink: CADisplayLink?
    fileprivate let frameRate = 60
    fileprivate var internalCounter = 0

    var tempo = 60.0
    var beatStep = BeatStep.fourth
    var handler: Handler?

    fileprivate var nextTickLength: Int {
        return Int(Double(frameRate) / (tempo / 60.0 * Double(beatStep.rawValue) / 4.0))
    }

    init() {
        displayLink = CADisplayLink(target: self, selector: #selector(fire))
        if #available(iOS 10.0, *) {
            displayLink?.preferredFramesPerSecond = frameRate
        }
        displayLink?.add(to: RunLoop.main, forMode: .commonModes)
        displayLink?.isPaused = true
    }

    deinit {
        displayLink?.remove(from: RunLoop.main, forMode: .commonModes)
    }

    func start() {
        displayLink?.isPaused = false
    }

    func stop() {
        displayLink?.isPaused = true
    }

    @objc func fire() {
        internalCounter += 1

        if internalCounter >= nextTickLength {
            internalCounter = 0
            handler?()
        }
    }
}
