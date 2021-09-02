//
//  Photos.swift
//  Photos
//
//  Created by Scott D. Bowen on 2/9/21.
//

import Foundation


/// An observable object representing a random list of space photos.
@MainActor
class Photos: ObservableObject {
    @Published private(set) var items: [SpacePhoto] = []
    var favourites: [SpacePhoto] = [ ]

    /// Updates `items` to a new, random list of `SpacePhoto`.
    func updateItems() async {
        let fetched = await fetchPhotos()
        items = fetched
    }

    func notSoRandomPhotoDates() -> [Date] {
        return [Date(),
                Date().addingTimeInterval(-1*24*60*60),
                Date().addingTimeInterval(-2*24*60*60),
                Date().addingTimeInterval(-3*24*60*60),
                Date().addingTimeInterval(-4*24*60*60),
                Date().addingTimeInterval(-5*24*60*60),
                Date().addingTimeInterval(-6*24*60*60),
                Date().addingTimeInterval(-7*24*60*60),
                Date().addingTimeInterval(-8*24*60*60),
                Date().addingTimeInterval(-9*24*60*60),
                Date().addingTimeInterval(-10*24*60*60),
                Date().addingTimeInterval(-11*24*60*60),
                Date().addingTimeInterval(-12*24*60*60),
                Date().addingTimeInterval(-13*24*60*60),
                Date().addingTimeInterval(-14*24*60*60),]
    }
    
    /// Fetches a new, random list of `SpacePhoto`.
    func fetchPhotos() async -> [SpacePhoto] {
        var downloaded: [SpacePhoto] = []
        for date in notSoRandomPhotoDates() {
            let url = SpacePhoto.requestFor(date: date)
            if let photo = await fetchPhoto(from: url) {
                downloaded.append(photo)
            }
        }
        return downloaded
    }

    /// Fetches a `SpacePhoto` from the given `URL`.
    func fetchPhoto(from url: URL) async -> SpacePhoto? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            // Bad Cache Implementation: downloaded[url] = data
            // print("* Caching: \(url), \(data.count), \(downloaded.count)")
            return try SpacePhoto(data: data)
        } catch {
            return nil
        }
    }
}
