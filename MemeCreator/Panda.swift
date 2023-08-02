//
//  Panda.swift
//  MemeCreator
//
//  Created by Gabriel Marquez on 2023-08-02.
//

import SwiftUI

// Step 1: This is the Panda model object. It’s structured to mirror the JSON data returned from this URL.
struct Panda: Codable {
    // Step 2: Each panda contains a text description as well as an imageUrl, which points to a panda image. This is the data is used to download a panda image.
    var description: String
    var imageUrl: URL?
    
    static let defaultPanda = Panda(description: "Cute Panda",
                                    imageUrl: URL(string: "https://assets.devpubs.apple.com/playgrounds/_assets/pandas/pandaBuggingOut.jpg"))
}

// Step 3: A PandaCollection is composed of an array of Panda model objects. This mirrors the format of the JSON data, which enables you to easily decode URLs and descriptive text from your JSON data into a PandaCollection instance.
struct PandaCollection: Codable {
    var sample: [Panda]
}
