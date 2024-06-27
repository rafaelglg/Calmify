//
//  PhotoPickerViewModel.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 26/6/24.
//

import Foundation
import PhotosUI
import SwiftUI

@Observable final class PhotoPickerViewModel {
    static let shared = PhotoPickerViewModel()
    
    var userVM = UserViewModel.shared
    var imageSelected: UIImage? = nil
    var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    
    private func setImage(from image: PhotosPickerItem?) {
        guard let image else { return }
        
        Task {
            if let data = try await image.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    imageSelected = uiImage
                    updateUserProfileImage (uiImage)
                }
            }
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
