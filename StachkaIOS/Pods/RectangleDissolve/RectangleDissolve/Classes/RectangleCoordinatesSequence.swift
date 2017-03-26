//
//  RectangleCoordinatesSequence.swift
//  GithubItunesViewer
//
//  Created by MIKHAIL RAKHMANOV on 12.02.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

struct RectangleCoordinatesIteratorConfiguration {
    let screenSize: CGSize
    let rectanglesHorizontal: Int
    let rectanglesVertical: Int
}

class RectangleCoordinatesIterator: IteratorProtocol {

    var currentPosition: (horizontal: Int, vertical: Int)
    let rectanglesHorizontal: Int
    let rectanglesVertical: Int
    let size: CGSize
    let rectangleSize: CGSize

    init(configuration: RectangleCoordinatesIteratorConfiguration) {
        rectanglesHorizontal = configuration.rectanglesHorizontal
        rectanglesVertical = configuration.rectanglesVertical
        size = configuration.screenSize
        currentPosition = (horizontal: -1, vertical: 0)
        rectangleSize = CGSize(width: size.width / CGFloat(rectanglesHorizontal),
                               height: size.height / CGFloat(rectanglesVertical))
    }

    func next() -> CGRect? {
        let newHorizontal = (currentPosition.horizontal + 1) % rectanglesHorizontal
        if newHorizontal < currentPosition.horizontal {
            currentPosition.vertical += 1
        }
        currentPosition.horizontal = newHorizontal

        if currentPosition.vertical == rectanglesVertical {
            return nil
        }

        let newOriginX = CGFloat(currentPosition.horizontal) * rectangleSize.width
        let newOriginY = CGFloat(currentPosition.vertical) * rectangleSize.height
        let newOrigin = CGPoint(x: newOriginX, y: newOriginY)

        return CGRect(origin: newOrigin, size: rectangleSize)
    }
}

class RectangleSequence: Sequence {
    typealias Iterator = RectangleCoordinatesIterator
    let configuration: RectangleCoordinatesIteratorConfiguration

    init(configuration: RectangleCoordinatesIteratorConfiguration) {
        self.configuration = configuration
    }

    func makeIterator() -> RectangleCoordinatesIterator {
        return RectangleCoordinatesIterator(configuration: configuration)
    }
}
