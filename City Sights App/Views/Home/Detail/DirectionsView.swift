//
//  DirectionsView.swift
//  City Sights App
//
//  Created by adrian garcia on 12/9/22.
//

import SwiftUI

struct DirectionsView: View {
    
    var business: Business
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                
                BusinessTitle(business: business)
                
                Spacer()
                
                if let lat = business.coordinates?.latitude,
                   let long = business.coordinates?.longitude,
                   let name = business.name {
                    
                    if let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let chale = URL(string: "http://maps.apple.com/?ll=\(lat),\(long)&q=\(encodedName)") {
                        
                        Link("Open in Maps", destination: chale )
                    }
                }
            }
            .padding()
            
            DirectionsMap(business: business)
                .ignoresSafeArea()
        }
    }
}


