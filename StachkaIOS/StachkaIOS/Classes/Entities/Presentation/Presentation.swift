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
    dynamic var presentationName: String = ""
    dynamic var date: NSDate = NSDate()
    dynamic var metaDescription: String = ""
    dynamic var hoursFrom: Int = 0
    dynamic var minutesFrom: Int = 0
    dynamic var minutesTo: Int = 0
    dynamic var hoursTo: Int = 0
    dynamic var fullDescription: String = ""
    dynamic var shortDescription: String = ""
    dynamic var place: String = ""
    dynamic var section: String = ""
    dynamic var category: String = ""
    dynamic var difficulty: String = ""
    dynamic var actualStartDate: NSDate = NSDate()
    dynamic var actualEndDate: NSDate = NSDate()
    dynamic var author: Author?

    enum Constants {
        static let dateTransform = TransformOf<NSDate, String>(fromJSON: { (string: String?) -> NSDate? in
            return string.flatMap { TimeInterval($0) }.map { Date(timeIntervalSince1970: $0) as NSDate }
        }, toJSON: { (date: NSDate?) -> String? in
            return date.map { String($0.timeIntervalSince1970) }
        })

        static let intStringTransform = TransformOf<Int, String>(fromJSON: { (string: String?) -> Int? in
            return string.flatMap { Int($0) }
        }, toJSON: { (int: Int?) -> String? in
            return int.map(String.init)
        })
    }

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        name             <- map["product_id"]
        presentationName <- map["product"]
        date             <- (map["day"], Constants.dateTransform)
        metaDescription  <- map["meta_description"]
        hoursTo          <- (map["hours_to"], Constants.intStringTransform)
        hoursFrom        <- (map["hours_from"], Constants.intStringTransform)
        minutesTo        <- (map["minutes_to"], Constants.intStringTransform)
        minutesFrom      <- (map["minutes_from"], Constants.intStringTransform)
        fullDescription  <- map["full_description"]
        shortDescription <- map["short_description"]
        category         <- map["short_features_values.1.variant"]
        place            <- map["short_features_values.2.variant"]
        section          <- map["short_features_values.3.variant"]
        difficulty       <- map["short_features_values.4.variant"]

        if let speakerId = map.JSON["speaker_ids"] as? String {
            let fullKey = "product_speaker." + speakerId
            author <- map[fullKey]
        }
    }

    func provideRelationships() -> [AutoObject] {
        if let relationship = author {
            return [relationship]
        }
        return []
    }
}
