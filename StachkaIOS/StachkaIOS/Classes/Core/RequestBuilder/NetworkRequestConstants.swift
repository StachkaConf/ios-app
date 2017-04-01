//
//  NetworkRequestConstants.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

enum NetworkRequestConstants {
    
    enum HeaderName: String {
        case contentType = "Content-Type"
        case accept = "Accept"
    }
    
    enum APIPath: String {
        case defaultPath = "https://nastachku.ru/api/"
    }
    
    enum APIMethodName: String {
        case products = "categories/3/products"
    }
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
}

