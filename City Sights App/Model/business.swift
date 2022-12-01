//
//  business.swift
//  City Sights App
//
//  Created by adrian garcia on 11/30/22.
//

import Foundation

struct Business: Codable {
    
    var id: String?
    var alias: String?
    var name: String?
    var image_url: String?
    var is_closed: Bool?
    var url: String?
    var review_count: Int?
    var categories: [Category]?
    var rating: Double?
    var coordinates: Coordinate?
    var transactions: [String]?
    var price: String?
    var location: Location?
    var phone: String?
    var display_phone: String?
    var distance: Double?
}

struct Category: Codable {
    var alias: String?
    var title: String?
}

struct Coordinate: Codable {
    var latitude: Double?
    var longitude: Double?
}

struct Location: Codable {
    var adress1: String?
    var adress2: String?
    var adress3: String?
    var city: String?
    var zip_code: String?
    var country: String?
    var state: String?
    var display_adress: [String]?
    
    
}
