//
//  SectionFilter.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 27.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import RealmSwift

protocol RelationshipsProvider {
    func provideRelationships() -> [AutoObject]
}

extension RelationshipsProvider {
    func provideRelationships() -> [AutoObject] { return [] }
}

class AutoObject: Object, RelationshipsProvider {

    // FIXME: временная мера для отслеживания времени создания объектов
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        let locale = Locale(identifier: "ru_RU")
        let dateFormat = "d MMMM yyyy года HH:mm"
        let timeZone = TimeZone(abbreviation: "GMT+4")
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        dateFormatter.dateFormat = dateFormat
        return dateFormatter
    }()

    dynamic var compoundKey: String = UUID().uuidString //+ AutoObject.dateFormatter.string(from: Date())

    override static func primaryKey() -> String? {
        return "compoundKey"
    }
}

class SectionFilter: AutoObject, Filter {
    dynamic var title: String = ""
    dynamic var selected: Bool = false

    func query() -> String {
        return "section = " + "'" + title + "'"
    }
}
