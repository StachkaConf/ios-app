//
//  FeedCellViewModelFactory.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 08.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol PresentationCellViewModelFactory {
    func sections(from presentations: [Presentation]) -> [PresentationSectionModel]
}
