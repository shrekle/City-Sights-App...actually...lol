//
//  ContentModel.swift
//  City Sights App
//
//  Created by adrian garcia on 11/28/22.
//

import SwiftUI
import Foundation
import CoreLocation

class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    
    @Published var path = NavigationPath()
    @Published var restaurants = [Business()]
    @Published var sights = [Business()]
    
    let locationManager = CLLocationManager()
    
    
    override init() {
        super.init() // init method for NSObject
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization() // this works in conjunction with the p list
        
    }
    
    
    //MARK: - location manager delegate methods
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            authorizationState = locationManager.authorizationStatus
            
        } else if locationManager.authorizationStatus == .denied {
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations.first
        
        if userLocation != nil {
            locationManager.stopUpdatingLocation()
            getBusinesses(category: Constants.restaurants, location: userLocation!)
            getBusinesses(category: Constants.sights, location: userLocation!)
        }
    }
    
    //MARK: - Yelp API Methods
    
    func runGetBusinesses(userLocation: CLLocation) {
        getBusinesses(category: Constants.restaurants, location: userLocation)
        getBusinesses(category: Constants.sights, location: userLocation)
    }
    
    func getBusinesses(category: String, location: CLLocation) {
        
        var urlComponent = URLComponents(string: Constants.apiUrl)
        
        urlComponent?.queryItems = [
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "10")
        ]
        
        let url = urlComponent?.url
        
        if let url {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            let sesh = URLSession.shared
            
            let _: Void = sesh.dataTask(with: request) { data, response, error in
                
                if error == nil {
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode(businessSearch.self, from: data!)
                        
                        var businesses = result.businesses
                        businesses.sort { b1, b2 in
                            return b1.distance ?? 0 < b2.distance ?? 0
                        }
                        
                        for b in businesses {
                            b.getImage()
                        }
                        
                        DispatchQueue.main.async {
                            switch category {
                            case Constants.sights:
                                self.sights = businesses
                            case Constants.restaurants:
                                self.restaurants = businesses
                            default:
                                break
                            }
                        }
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
}

