//
//  Presentation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 01.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class Presentation: AutoObject, Mappable {
    dynamic var name: String = ""

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {

    }
}
