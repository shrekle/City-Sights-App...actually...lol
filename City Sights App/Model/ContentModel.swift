//
//  ContentModel.swift
//  City Sights App
//
//  Created by adrian garcia on 11/28/22.
//

import Foundation
import CoreLocation





class ContentModel: NSObject, ObservableObject {
    
    let locationManager = CLLocationManager()
      
    @Published var restaurants = [Business()]
    @Published var sights = [Business()]
    
    //***** this overrides the init from NSObject. We add super.init() to also run the init from NSObject plus add to it want we want, in this case we want to add the methods from CLLocationManagerDelegate as well, and to set the ContentModel as the delegate for  CLLocationManager()*****
    override init() {
        
        // init method for NSObject
        super.init()
        locationManager.delegate = self

//        request for permission to get location
        locationManager.requestWhenInUseAuthorization()
        
    }
}

//MARK: - location manager delegate methods
extension ContentModel:  CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            
            //        if theres permission that get location
                    locationManager.startUpdatingLocation()
            
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
}


//MARK: - Yelp API Methods
extension ContentModel {
    func getBusinesses(category: String, location: CLLocation) {
        
        var urlComponent = URLComponents(string: Constants.apiUrl)
        
        urlComponent?.queryItems = [
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "category", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        
        let url = urlComponent?.url
        
        if let url {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            let sess = URLSession.shared
            
            let dataTask: Void = sess.dataTask(with: request) { data, response, error in
                
                if error == nil {
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode(businessSearch.self, from: data!)
                        DispatchQueue.main.async {
                            
                            switch category {
                            case Constants.restaurants:
                                self.restaurants = result.businesses
                            case Constants.sights:
                                self.sights = result.businesses
                            default:
                                break
                            }
                            self.restaurants = result.businesses
                            
                        }
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
}
