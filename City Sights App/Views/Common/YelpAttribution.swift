//
//  YelpAttribution.swift
//  City Sights App
//
//  Created by adrian garcia on 12/10/22.
//

import SwiftUI

struct YelpAttribution: View {
    
    var link: String
    
    var body: some View {
        
        Link(destination: URL(string: link)!) {
            Image(Constants.yelp)
                .resizable()
                .scaledToFit()
                .frame(height: 36)
        }    }
}

struct YelpAttribution_Previews: PreviewProvider {
    static var previews: some View {
        YelpAttribution(link: "chale")
    }
}
