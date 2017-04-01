//
//  JSONDeserializer.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class JSONDeserializer: Deserializer {

    func deserialize(data: Data) throws -> Any {
        return try JSONSerialization.jsonObject(with: data, options: [])
    }
}

