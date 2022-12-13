//
//  LocationDeniedView.swift
//  City Sights App
//
//  Created by adrian garcia on 12/10/22.
//

import SwiftUI

struct LocationDeniedView: View {
    
    private var bgColor = Color(red: 34/255, green: 141/255, blue: 138/255)
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("WHOOOPS!!!")
                .font(.largeTitle)
                .bold()
            
            Text("You done screwed up big dawg")
            
            Spacer()
            
            Button {
                
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            } label: {
                Text("Go to Settings")
                    .bold()
                    .foregroundColor(bgColor)
            }
            .buttonStyle(onBoardingButton(otherColor: bgColor))
            Spacer()
        }
        .padding()
        .background(bgColor)
        .multilineTextAlignment(.center)
    }
}

struct LocationDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeniedView()
    }
}
