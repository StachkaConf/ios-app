//
//  PresentationInfoViewModelFactory.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 10.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import RxDataSources

protocol PresentationInfoCellViewModelFactory {
    func section(from presentation: Presentation) -> CellSectionModel
}
