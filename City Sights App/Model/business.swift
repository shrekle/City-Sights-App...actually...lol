//
//  business.swift
//  City Sights App
//
//  Created by adrian garcia on 11/30/22.
//

import Foundation

class Business: ObservableObject, Identifiable, Codable {
  
   @Published var imageData: Data?
    
    var id: String?
    var alias: String?
    var name: String?
    var imageUrl: String?
    var isClosed: Bool?
    var url: String?
    var reviewCount: Int?
    var categories: [Category]?
    var rating: Double?
    var coordinates: Coordinate?
    var transactions: [String]?
    var price: String?
    var location: Location?
    var phone: String?
    var displayPhone: String?
    var distance: Double?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case isClosed = "is_closed"
        case reviewCount = "review_count"
        case displayPhone = "display_phone"
        
        case id
        case alias
        case name
        case url
        case categories
        case rating
        case coordinates
        case transactions
        case price
        case location
        case phone
        case distance
    }
    
    func getImage() {
        guard let imageUrl else {return}
        guard let url = URL(string: imageUrl) else {return}
        
        let sesh = URLSession.shared

        let _ = sesh.dataTask(with: url) { data, response, error in
            guard error == nil else {return}
            guard let data else {return}

            DispatchQueue.main.async {
                self.imageData = data
            }
        }.resume()
    }
}

struct Category: Codable, Equatable{
    var alias: String?
    var title: String?
}

struct Coordinate: Codable, Equatable {
    var latitude: Double?
    var longitude: Double?
}

struct Location: Codable, Equatable {
    var adress1: String?
    var adress2: String?
    var adress3: String?
    var city: String?
    var zipCode: String?
    var country: String?
    var state: String?
    var displayAdress: [String]?
    
    enum CodingKeys: String, CodingKey {
        case zipCode = "zip_code"
        case displayAdress = "display_adress"
        
        case adress1
        case adress2
        case adress3
        case city
        case country
        case state
    }
}


