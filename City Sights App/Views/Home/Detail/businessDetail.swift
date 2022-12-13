//
//  businessDetail.swift
//  City Sights App
//
//  Created by adrian garcia on 12/5/22.
//

import SwiftUI

struct businessDetail: View {
    
    @State private var showDirections = false
    
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
                        .foregroundColor(business.isClosed ?? false ? .gray:.blue)
                    
                    Text(business.isClosed ?? false ? "Closed":"Open")
                        .bold()
                        .foregroundColor(.white)
                }
            } // Vstack
            
            Group {
                HStack {
                    BusinessTitle(business: business)
                        .padding()
                    
                    Spacer()
                    
                    YelpAttribution(link: business.url!)
                        .padding(.trailing, -20)
                }
               
                
                DashedDivider()

                HStack {
                    Text("Phone:")
                        .bold()
                    Text(business.displayPhone ?? "")
                    Spacer()
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                }
                DashedDivider()

                HStack {
                    Text("Reviews:")
                        .bold()
                    Text(String(business.reviewCount ?? 0))
                    Spacer()
                    Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                }
                
                DashedDivider()

                HStack {
                    Text("Website:")
                        .bold()
                    Text(business.url ?? "")
                        .lineLimit(1)
                    Spacer()
                    Link("Visit", destination: URL(string: "\(business.url ?? "")")!)
                }
                
                DashedDivider()

            } // group
            .padding(.vertical, 5)
            .padding(.horizontal)
            
            Button {
                showDirections = true
            } label: {
                ZStack {
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                    
                    Text("Get Directions")
                        .foregroundColor(.white)
                    
                }
            }
            .padding([.bottom, .horizontal])
            .sheet(isPresented: $showDirections) {
                DirectionsView(business: business)
            }
        }
    }
}

//struct businessDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        businessDetail()
//    }
//}
