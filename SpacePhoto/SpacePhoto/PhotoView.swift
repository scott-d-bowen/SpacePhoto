//
//  PhotoView.swift
//  PhotoView
//
//  Created by Scott D. Bowen on 2/9/21.
//

import SwiftUI
import Foundation
import URLImage

struct PhotoView: View {
    var photo: SpacePhoto

    var body: some View {
        ZStack(alignment: .bottom) {
            
            URLImage(photo.hdurl) {
                // This view is displayed before download starts
                EmptyView()
            } inProgress: { progress in
                // Display progress
                ProgressView()
            } failure: { error, retry in
                // Display error and retry button
                VStack {
                    Text(error.localizedDescription)
                    Button("Retry", action: retry)
                }
            } content: { image in image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(minWidth: 0, minHeight: 400)

            HStack {
                Text("\(photo.id) : \(photo.title)")
                Spacer()
                SavePhotoButton(photo: photo)
            }
            .padding()
            .background(.thinMaterial)
        }
        .background(.thickMaterial)
        .mask(RoundedRectangle(cornerRadius: 16))
        .padding(.bottom, 8)
    }
}
