//
//  FilterService.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 30.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import RxSwift
import RealmSwift

protocol FilterService {
    func updateFilters(_ types: [Object.Type]) -> Observable<[Filter]>
    func save(_ filters: [Filter]) -> Observable<Void>
}
