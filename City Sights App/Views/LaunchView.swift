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
        VStack{
            if model.authorizationState == .notDetermined {
                OnboardingView()
            }
            else if model.authorizationState == .authorizedWhenInUse || model.authorizationState == .authorizedAlways {
                HomeView()
            }
            else {
                LocationDeniedView()
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView().environmentObject(ContentModel())
    }
}
