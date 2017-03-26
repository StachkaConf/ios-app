//
//  RandomArrayIndicesSequence.swift
//  GithubItunesViewer
//
//  Created by MIKHAIL RAKHMANOV on 12.02.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class BatchRandomArrayIndicesIterator: IteratorProtocol {
    let indicesIterator: RandomArrayIndicesIterator
    let batchSize: Int

    init(max: Int, batchSize: Int) {
        indicesIterator = RandomArrayIndicesIterator(max: max)
        self.batchSize = batchSize
    }

    func next() -> [Int]? {
        var batch: [Int] = []
        while batch.count < batchSize, let element = indicesIterator.next() {
            batch.append(element)
        }

        return batch.count != 0 ? batch : nil
    }
}

class RandomArrayIndicesIterator: IteratorProtocol {

    var array: [Int] = []
    var currentMax: Int = 0

    init(max: Int) {
        array = (1 ... max).enumerated().map { offset, element in
            return offset
        }
        currentMax = array.count - 1
    }

    func next() -> Int? {
        guard currentMax >= 0 else {
            return nil
        }

        let randomElementIndex = Int(arc4random_uniform(UInt32(currentMax)))
        let randomElement = array[randomElementIndex]

        if randomElementIndex != currentMax {
            swap(&array[randomElementIndex], &array[currentMax])
        }
        currentMax -= 1

        return randomElement
    }
}

class RandomArrayIndicesSequence: Sequence {
    typealias Iterator = RandomArrayIndicesIterator
    let max: Int

    init(max: Int) {
        self.max = max
    }

    func makeIterator() -> RandomArrayIndicesIterator {
        return RandomArrayIndicesIterator(max: max)
    }
}
