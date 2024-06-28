//
//  PhotoPickerViewModel.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 26/6/24.
//

import Foundation
import PhotosUI
import SwiftUI

@Observable class PhotoPickerViewModel {
    static let shared = PhotoPickerViewModel()
    
    var userVM = UserViewModel.shared
    var setImageTask: Task<(),Never>? = nil
    var imageSelected: UIImage? = nil
    var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImageTask = Task {
                await setImage(from: imageSelection)
            }
            setImageTask?.cancel()
        }
    }
    
    private func setImage(from image: PhotosPickerItem?) async {
        guard let image else { return }
        
        do {
            if let data = try await image.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                await self.updateImageSelected(uiImage)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func updateImageSelected(_ uiImage: UIImage) async {
        await MainActor.run {
            imageSelected = uiImage
            updateUserProfileImage (uiImage)
        }
    }
    
    private func updateUserProfileImage(_ uiImage: UIImage) {
        if let data = uiImage.pngData() {
            // Save image data as base64 string or file path
            let base64String = data.base64EncodedString()
            userVM.updateProfilePicture(with: base64String)
        }
    }
}
