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

    dynamic var name: String = ""
    dynamic var position: String = ""
    dynamic var fullDescription: String = ""
    dynamic var email: String = ""
    dynamic var city: String = ""
    dynamic var skype: String = ""
    dynamic var phone: String = ""
    dynamic var imageUrlString: String = ""

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        name <- map["product"]
        fullDescription <- map["full_description"]
        email <- map["email"]
        city <- map["city"]
        skype <- map["skype"]
        phone <- map["phone"]
        imageUrlString <- map["main_pair.icon.image_path"]
    }
}
