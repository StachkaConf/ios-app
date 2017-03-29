//
//  ConferencesCoordinatorOutput.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 27.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import RxSwift

protocol ConferencesCoordinatorOutput {
    var filtersChanged: Observable<[Filter]> { get }
}
