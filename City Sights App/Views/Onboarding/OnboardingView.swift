//
//  OnboardingView.swift
//  City Sights App
//
//  Created by adrian garcia on 12/10/22.
//

import SwiftUI
import CoreLocation

struct OnboardingView: View {
    
    @EnvironmentObject var model: ContentModel
    
    @State private var tabSelection = 0
    
    private let blue = Color(red: 0/255, green: 130/255, blue: 167/255)
    private let turquoise = Color(red: 55/255, green: 197/255, blue: 192/255)
    
    var body: some View {
        VStack{
            
            TabView(selection: $tabSelection) {
                VStack {
                    Image(Constants.background1)
                        .resizable()
                        .scaledToFit()
                    
                    Text("Welcome to City Sights")
                        .font(.title)
                        .bold()
                    Text("balh blah blah")
                }
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .tag(0)
                
                VStack {
                    Image(Constants.background2)
                        .resizable()
                        .scaledToFit()
                    
                    Text("Ready to Discover Your City")
                        .font(.title)
                        .bold()
                    Text("balh blah blah")
                }
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .tag(1)
                
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            
            Button {
                if tabSelection == 0 {
                    tabSelection = 1
                } else {
                        model.requestGeoLocationPermission()
                }
            } label: {
                ZStack {
                    Text(tabSelection == 0 ? "Next" : "Get Location")
                }
            }
            .buttonStyle(onBoardingButton(tabSelection: tabSelection, blue: blue, turquoise: turquoise))
            Spacer()
        }
        .padding()
        .background(tabSelection == 0 ? blue:turquoise)
    }
}

//else {
//    if model.locationManager.authorizationStatus == .notDetermined {
//    model.requestGeoLocationPermission()
//    } else {
//        LocationDeniedView()
//    }

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

 struct onBoardingButton: ButtonStyle {
    
    var tabSelection: Int?
    var blue: Color?
    var turquoise: Color?
     var otherColor: Color?
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .frame(height: 48)
            
            configuration.label
                .bold()
                .foregroundColor(tabSelection == nil ? otherColor : (tabSelection == 0 ? blue:turquoise))
                .padding()
        }
    }
}
