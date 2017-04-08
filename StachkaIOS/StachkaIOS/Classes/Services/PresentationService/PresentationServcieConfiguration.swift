//
//  PresentationServcieConfiguration.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 01.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

struct PresentationServcieConfiguration: URLParametersTransformable, URLBuilderConfiguration {
    var itemsPerPage: Int?
    var sortParameter: String?
    var startingPage: Int?

    func toDictionary() -> [String: String] {
        var dictionary: [String: String] = [:]
        if let itemsPerPage = itemsPerPage {
            dictionary["items_per_page"] = String(itemsPerPage)
        }
        if let sortParameter = sortParameter {
            dictionary["sort_by"] = sortParameter
        }
        return dictionary
    }
}
