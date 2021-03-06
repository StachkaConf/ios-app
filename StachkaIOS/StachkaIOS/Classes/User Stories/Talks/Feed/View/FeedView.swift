//
//  FeedView.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import RxSwift
import Foundation

protocol FeedView: class {
    var indexSelected: Observable<IndexPath> { get }
    var indexDisplayed: Observable<IndexPath> { get }
    var filterSelected: Observable<Void> { get }
}
