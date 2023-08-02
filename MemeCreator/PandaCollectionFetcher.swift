//
//  PandaCollectionFetcher.swift
//  MemeCreator
//
//  Created by Gabriel Marquez on 2023-08-02.
//

import SwiftUI

// Step 1: PandaCollectionFetcher handles data fetching of the app. It’s an observable object, which allows it to publish changes to its values to all UI elements observing them. In this case, you’ll have an image view that’s waiting for new Panda data so it can update its image and description.
class PandaCollectionFetcher: ObservableObject {
    // Step 2: There are two published values: imageData, a PandaCollection that is populated with JSON data, and currentPanda, a Panda model object that is displayed in the app’s UI.
    @Published var imageData = PandaCollection(sample: [Panda.defaultPanda])
    @Published var currentPanda = Panda.defaultPanda
    
    let urlString = "http://playgrounds-cdn.apple.com/assets/pandaData.json"
    
    enum FetchError: Error {
        case badRequest
        case badJSON
    }
    // Step 3: The fetchData function retrieves the JSON data. Notice that it’s marked as async to indicate that the function runs asynchronously. Because it might take a little time to fetch the data from the internet, an async function pauses until the data returns. In the meantime, the app’s code continues to run in the background.
    // Tip: If this didn’t make fetchData asynchronous, the app might experience some lag while it loads images individually.
     func fetchData() async
    // Step 4: The function is also marked throws. This tells you that the function can throw an error when you call it. In MemeCreator, the code handles this error with try? by ignoring any values it throws.
     throws  {
         // Step 5: Inside fetchData, check to see if you have a valid URL.
        guard let url = URL(string: urlString) else { return }
         
         // Step 6: Call another async function — URLSession.shared.data(for:) — which passes in a URL request using the URL that has been defined. This call is also marked await, because this is where the function pauses as it waits for the response from the URL request.
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
         // Step 7: After the data returns, it is necesary to check the URL response to verify that it didn’t receive an error. This code generates a badRequest error if the response’s status code isn’t equal to 200, indicating a successful request.
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badRequest }

        Task { @MainActor in
            // Step 8: Finally, decode the JSON data and assign it to the published variable, imageData. Now we have all of the data we need to create panda memes.
            imageData = try JSONDecoder().decode(PandaCollection.self, from: data)
        }
    }
    
}

