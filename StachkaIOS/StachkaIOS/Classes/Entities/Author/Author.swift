//
//  Author.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 07.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import ObjectMapper
import ObjectMapper_Realm

class Author: AutoObject, Mappable {

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {

    }
}
