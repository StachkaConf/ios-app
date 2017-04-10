//
//  SectionHeader.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 08.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit
import RxDataSources

struct CellSectionModel {
    var items: [Item]
}

extension CellSectionModel: SectionModelType {
    typealias Item = CellViewModel

    init(original: CellSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}

