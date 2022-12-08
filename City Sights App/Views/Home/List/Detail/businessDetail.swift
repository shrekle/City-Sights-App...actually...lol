//
//  businessDetail.swift
//  City Sights App
//
//  Created by adrian garcia on 12/5/22.
//

import SwiftUI

struct businessDetail: View {
    
    var business: Business
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 0) {
                
                GeometryReader { geo in
                    
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                } // Geo
                .ignoresSafeArea(.all, edges: .top)
                
                ZStack {
                    Rectangle()
                        .frame(height: 36)
                        .foregroundColor(business.isClosed! ? .gray:.blue)
                    
                    Text(business.isClosed! ? "Closed":"Open")
                        .bold()
                        .foregroundColor(.white)
                }
            } // Vstack
            
            Group {
                Text(business.name!)
                if business.location?.displayAdress != nil {
                    
                    ForEach(business.location!.displayAdress!, id: \.self) { displayLine in
                        Text(displayLine)
                    }
                }
                Image("regular_\(business.rating ?? 0)")
                
                Divider()
                
                HStack {
                    Text("Phone:")
                        .bold()
                    Text(business.displayPhone ?? "")
                    Spacer()
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                }
                Divider()
                
                HStack {
                    Text("Reviews:")
                        .bold()
                    Text(String(business.reviewCount ?? 0))
                    Spacer()
                    Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                }
                
                Divider()
                
                HStack {
                    Text("Website:")
                        .bold()
                    Text(business.url ?? "")
                        .lineLimit(1)
                    Spacer()
                    Link("Visit", destination: URL(string: "\(business.url ?? "")")!)
                }
                
                Divider()
                
            } // group
            .padding(.vertical, 5) //if you apply padding to a Group, the group will apply it to all its child views
            Button {
                
            } label: {
                ZStack {
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                    
                    Text("Get Directions")
                        .foregroundColor(.white)
                    
                }
            } // Label of Button
            .padding(.bottom)
        }
    }
}

//struct businessDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        businessDetail()
//    }
//}
