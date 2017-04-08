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
        let filteredArray: [[String: Any]] = array.filter(isPresentation)

        return mapper.mapArray(JSONArray: filteredArray) ?? []
    }

    private func isPresentation(_ element: [String: Any]) -> Bool {
        let isPresentation = (element["is_presentation"] as? Bool) ?? false
        if !isPresentation { return false }

        let isApproved = (element["presentation_status"] as? String ?? "") == "S"
        return isApproved
    }
}
