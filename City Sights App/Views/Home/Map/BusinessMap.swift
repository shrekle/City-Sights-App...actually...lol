//
//  BusinessMap.swift
//  City Sights App
//
//  Created by adrian garcia on 12/7/22.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
    
    var Locations: [MKPointAnnotation] {
        
        var annotation = [MKPointAnnotation]()
        
        for business in model.restaurants + model.sights {
            
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                annotation.append(a)
            }
            
        } // IF
        return annotation
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
            
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(Locations)
        uiView.showAnnotations(Locations, animated: true) // this make it zoom into the group of pin locations where just addAnnotations put a pin on the general location from  further away
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
    }
}
