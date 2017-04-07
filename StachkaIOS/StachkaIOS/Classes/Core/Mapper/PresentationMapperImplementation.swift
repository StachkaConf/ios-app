//
//  PresentationMapperImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 07.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import ObjectMapper

class PresentationMapperImplementation: PresentationMapper {

    let mapper = Mapper<Presentation>()

    func mapArray(_ array: Any?) -> [Presentation] {
        guard let array = array as? [[String: Any]] else {
            return []
        }
        return mapper.mapArray(JSONArray: array) ?? []
    }
}
