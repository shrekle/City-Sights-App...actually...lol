//
//  HomeView.swift
//  City Sights App
//
//  Created by adrian garcia on 12/1/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var isMapShowing = false
    @State var selectedBusiness: Business?
    
    var body: some View {
        
        if model.restaurants.count != 0 && model.sights.count != 0 {
            
            NavigationStack(path: $model.path) {
                if !isMapShowing {
                    VStack {
                        HStack {
                            Image(systemName: "location")
                            Text(model.placemark?.locality ?? "").bold()
                            Spacer()
                            Button("Switch To Map") {
                                isMapShowing = true
                            }
                        }
                        
                        Divider()
                        
                        ZStack(alignment: .top) {
                            
                            BusinessList()
                            
                            HStack {
                                Spacer()
                                YelpAttribution(link: "https://yelp.ca")
                                    .padding(.trailing, -20)
                            }
                            
                        }
                    }
                    .padding([.horizontal])
                    .toolbar(.hidden)
                } else {
                    
                    ZStack(alignment: .top) {
                        BusinessMap(selectedBusiness: $selectedBusiness)
                            .ignoresSafeArea()
                            .sheet(item: $selectedBusiness) { business in
                                businessDetail(business: business)
                            }
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(height: 48)
                                .cornerRadius(5)
                            
                            HStack {
                                Image(systemName: "location")
                                Text(model.placemark?.locality ?? "").bold()
                                Spacer()
                                Button("Switch To Business list") {
                                    isMapShowing = false
                                }
                                .padding(.all)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            //            .toolbar(.hidden)
        } else {ProgressView().tint(.purple).scaleEffect(8)}
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(ContentModel())
    }
}
