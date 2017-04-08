//
//  PresentationSectionModel.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 08.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import RxDataSources

struct PresentationSectionModel {
    var timeString: String
    var items: [Item]
}

extension PresentationSectionModel: SectionModelType {
    typealias Item = PresentationCellViewModel

    init(original: PresentationSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}
