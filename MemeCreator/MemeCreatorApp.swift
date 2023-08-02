//
//  MemeCreatorApp.swift
//  MemeCreator
//
//  Created by Gabriel Marquez on 2023-08-02.
//

import SwiftUI

@main
struct MemeCreatorApp: App {
    // To fetch its data, this app uses an observable object, PandaCollectionFetcher.
    // This is where all of the data fetching occurs.
    @StateObject private var fetcher = PandaCollectionFetcher()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                // To share its data, MemeCreator passes in PandaCollectionFetcher as an environment object, making it available to all of the child views of MemeCreator. An environment object must also be an observable object, which enables all views observing its data to update whenever that data changes.
                
                MemeCreator()
                    .environmentObject(fetcher)
            }
        }
    }
}
