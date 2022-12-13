//
//  BusinessTitle.swift
//  City Sights App
//
//  Created by adrian garcia on 12/9/22.
//

import SwiftUI

struct BusinessTitle: View {
    
    var business: Business
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(business.name!)
                .font(.title2)
                .bold()
            
            if business.location?.displayAdress != nil {
                ForEach(business.location!.displayAdress!, id: \.self) { displayLine in
                    Text(displayLine)
                }
            }
            
            Image("regular_\(business.rating ?? 0)")
            
        }
    }
}
