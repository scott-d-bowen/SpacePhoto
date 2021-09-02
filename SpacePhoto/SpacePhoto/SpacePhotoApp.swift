//
//  SpacePhotoApp.swift
//  SpacePhoto
//
//  Created by Scott D. Bowen on 2/9/21.
//

import SwiftUI
import URLImage
import URLImageStore

@main
struct SpacePhotoApp: App {
    var body: some Scene {
        WindowGroup {
            // ContentView()
            CatalogView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // ContentView()
        CatalogView()
    }
}

struct CatalogView: View {
    @StateObject private var photos = Photos()

    var body: some View {
        
        let urlImageService = URLImageService(fileStore: URLImageFileStore(),
                                                  inMemoryStore: URLImageInMemoryStore())
        //NavigationView {
            List {
                ForEach(photos.items) { item in
                    PhotoView(photo: item)
                        // iOS only!: .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Catalog")
            .listStyle(.plain)
            .refreshable {
                await photos.updateItems()
            }
        // }
        .task {
            await photos.updateItems()
        }
        .environment(\.urlImageService, urlImageService)
    }
}
