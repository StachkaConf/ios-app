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

    enum Constants {
        private static var UTCDateFormatter = { () -> DateFormatter in 
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")!
            return dateFormatter
        }()

        static let dateTransform = TransformOf<NSDate, String>(fromJSON: { (string: String?) -> NSDate? in
            return Constants.UTCDateFormatter.date(from: string ?? "") as NSDate?
        }, toJSON: { (date: NSDate?) -> String? in
            let date = date as Date?
            return Constants.UTCDateFormatter.string(from: date ?? Date())
        })

        static let intStringTransform = TransformOf<Int, String>(fromJSON: { (string: String?) -> Int? in
            return Int(string ?? "0")
        }, toJSON: { (int: Int?) -> String? in
            return String(int ?? 0)
        })
    }

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        presentationName <- map["product"]
        date <- (map["updated_timestamp"], Constants.dateTransform)
        metaDescription <- map["meta_description"]
        hoursTo <- (map["hours_to"], Constants.intStringTransform)
        hoursFrom <- (map["hours_from"], Constants.intStringTransform)
        minutesTo <- (map["minutes_to"], Constants.intStringTransform)
        minutesFrom <- (map["minutes_from"], Constants.intStringTransform)
        fullDescription <- map["full_description"]
        shortDescription <- map["short_description"]
    }
}
