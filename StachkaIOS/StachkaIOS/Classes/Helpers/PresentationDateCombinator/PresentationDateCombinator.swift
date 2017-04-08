//
//  PresentationDateCombinator.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 08.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol PresentationDateCombinator {
    func combineDates(in presentations: [Presentation]) -> [Presentation]
}
