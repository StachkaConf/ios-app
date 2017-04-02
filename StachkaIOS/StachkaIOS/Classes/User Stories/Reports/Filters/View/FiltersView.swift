//
//  FiltersView.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 29.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import RxSwift

protocol FiltersView: class {
    var indexSelected: Observable<IndexPath> { get }
    var dissappear: Observable<Void> { get }
}
