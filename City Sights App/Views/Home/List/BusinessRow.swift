//
//  BusinessRow.swift
//  City Sights App
//
//  Created by adrian garcia on 12/2/22.
//

import SwiftUI

struct BusinessRow: View {
    
   @ObservedObject var business: Business
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                
                let uiImage = UIImage(data: business.imageData ?? Data())
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .frame(width: 58, height: 58)
                    .cornerRadius(10)
                    .scaledToFit()
                
                VStack(alignment: .leading) {
                    Text(business.name ?? "")
                    Text(String(format: "%.1f km away", (business.distance ?? 0)/1000)) //format parameter goes first!!!!!!!!!!!!!!!!!!!!!!
                        .font(.caption)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Image("regular_\(business.rating ?? 0.0)")
                    Text("\(String(business.reviewCount ?? 0)) Reviews")
                        .font(.caption)
                }
            }
            
            Divider()
            
        }
        .tint(.black)
    }
}
//
//struct BusinessRow_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessRow()
//    }
//}
