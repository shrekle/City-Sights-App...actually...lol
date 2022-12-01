//
//  BusinessSearch.swift
//  City Sights App
//
//  Created by adrian garcia on 11/30/22.
//

import Foundation

struct businessSearch: Codable {
    
    var businesses = [Business]()
    var total = 0
    var region = Region()
    
}

struct Region: Codable {
    var center = Coordinate()
}
