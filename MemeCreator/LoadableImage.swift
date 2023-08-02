//
//  LoadableImage.swift
//  MemeCreator
//
//  Created by Gabriel Marquez on 2023-08-02.
//

import SwiftUI

// Step 1: After having the JSON data, we can use it to load panda images. To accomplish this, compose the LoadableImage view from AsyncImage, a view that loads an image asynchronously.
struct LoadableImage: View {
    //Step 2: To create an image, LoadableImage needs data about the Panda it’s loading. The metadata supplied here includes the image URL and the description.
    var imageMetadata: Panda
    
    var body: some View {
        // Step 3: Inside the view body, create an AsyncImage and pass in the imageUrl to load the panda image. An AsyncImage view loads asynchronously, so we will need to show something in its place while the image loads, and show something else if image loading fails. We will handle all of this logic in the following if statement.
        // Step 4: When we create an instance of AsyncImage, SwiftUI provides us with phase data, which updates us on the state of image loading. For example, phase.error provides us with errors that occur, while phase.image provides an image, if available. We can use the phase data to show the appropriate UI based on the phase state.
        AsyncImage(url: imageMetadata.imageUrl) { phase in
            //Step 5: Check to see if an image is available. If there is, great — this is the panda image we will display using the description as the accessibility text.
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .accessibility(hidden: false)
                    .accessibilityLabel(Text(imageMetadata.description))
            // Step 6: Check to see if any errors occurred while loading the image. If so, we can provide a view that tells the user something went wrong.
            }  else if phase.error != nil  {
                VStack {
                    Image("pandaplaceholder")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300)
                    Text("The pandas were all busy.")
                        .font(.title2)
                    Text("Please try again.")
                        .font(.title3)
                }
                
            } else {
                // Step 7: If we haven’t received an image and we don’t have an error, that means the image is loading. To let people know that the image is downloading, use ProgressView to display an animation while the image loads.
                ProgressView()
            }
        }
    }
}

struct Panda_Previews: PreviewProvider {
    static var previews: some View {
        LoadableImage(imageMetadata: Panda.defaultPanda)
    }
}

