//
//  CitySightsApp.swift
//  City Sights App
//
//  Created by adrian garcia on 11/28/22.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
