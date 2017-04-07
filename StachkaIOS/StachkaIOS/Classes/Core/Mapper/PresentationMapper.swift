//
//  PresentationMapper.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 07.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol PresentationMapper {
    func mapArray(_ array: Any?) -> [Presentation]
}
