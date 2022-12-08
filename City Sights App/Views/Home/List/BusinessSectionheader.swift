//
//  BusinessSectionheader.swift
//  City Sights App
//
//  Created by adrian garcia on 12/2/22.
//

import SwiftUI

struct BusinessSectionheader: View {
    
    var title: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)
            
            Text(title).bold()
        }
    }
}

struct BusinessSectionheader_Previews: PreviewProvider {
    static var previews: some View {
        BusinessSectionheader(title: "restautants")
    }
}
