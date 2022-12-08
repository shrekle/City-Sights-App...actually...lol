//
//  BusinessSection.swift
//  City Sights App
//
//  Created by adrian garcia on 12/2/22.
//

import SwiftUI

struct BusinessSection: View {
    
    var title: String
    var businesses: [Business]
    
    var body: some View {
        
        Section {
            ForEach(businesses) { business in
                
                NavigationLink {
                    businessDetail(business: business)
                } label: {
                    BusinessRow(business: business)
                    
                }
            }
        } header: {
            BusinessSectionheader(title: title)
        }
    }
}

