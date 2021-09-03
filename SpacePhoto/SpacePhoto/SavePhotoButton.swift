//
//  SavePhotoButton.swift
//  SavePhotoButton
//
//  Created by Scott D. Bowen on 2/9/21.
//

import SwiftUI
import Foundation

struct SavePhotoButton: View {
    var photo: SpacePhoto
    @State private var isSaving = false

    var body: some View {
        Button {
            Task {
                isSaving = true
                await photo.save(photo)
                isSaving = false
            }
        } label: {
            Text("Save")
                .opacity(isSaving ? 0 : 1)
                .overlay {
                    if isSaving {
                        ProgressView()
                    }
                }
        }
        .disabled(isSaving)
        .buttonStyle(.bordered)
    }
}
