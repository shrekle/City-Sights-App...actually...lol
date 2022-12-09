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
    @Binding var selectedBusiness: Business?
    
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
        
        mapView.delegate = context.coordinator
        
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
    
    //MARK: - Coordinator class
    //this makeCoordinator is a method of businessMap
    func makeCoordinator() -> Coordinator {
        return Coordinator(map: self) //since BusinessMap is the delegate of the Coordinator class we reference it as self
    }
    // coordinator class has to be inside the businessMap class UIRepresentable/ parent struct
    class Coordinator: NSObject, MKMapViewDelegate {
        
        let map: BusinessMap
        
        // need to have this initializer with a parameter so when the coordinator class is created it need the parameter input, like in the makeCoordinator method of the mapView class
        init(map: BusinessMap) {
            self.map = map
        }
        
        //inside this coordinator class we dont actually have access to the businessMap properties and crap
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            //to show the blue dot of the users location
            if annotation is MKUserLocation {
                return nil
            }
            
            //check if there is a reusable annotationView first
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.annotationReuseId)
            
            if annotationView == nil {
                
                // create annotationView
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.annotationReuseId)
                
                //properties i can set on the annotatioView that i will return
                annotationView!.canShowCallout = true //this let you call extra information in the call out bubble, in this case a trailing accessory item
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) //  this is the litle circle with the i
            } else {
                
                // when reusing annotation we just need to change the old annotation info with the new one coming in
                annotationView!.annotation = annotation
            }
            
            // make sure to assign the delegate in makeUiView()
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            for business in map.model.restaurants + map.model.sights {
                if business.name == view.annotation?.title {
                    map.selectedBusiness = business
                    return
                }
            }
        }
    }
}
