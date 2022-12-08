//
//  LaunchView.swift
//  City Sights App
//
//  Created by adrian garcia on 11/28/22.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        if model.authorizationState == .denied {
            
        }
        else if model.authorizationState == .authorizedWhenInUse || model.authorizationState == .authorizedAlways {
            HomeView()
        }
        else {
            
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView().environmentObject(ContentModel())
    }
}
