//
//  FilterModuleOutput.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 27.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import RxSwift

protocol FiltersMainModuleOutput: ModuleOutput {
    var parentFilterSelected: Observable<ParentFilter> { get }
}
