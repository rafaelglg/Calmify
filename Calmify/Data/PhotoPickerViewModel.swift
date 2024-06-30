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
    
    var userVM: UserViewProtocol
    var setImageTask: Task<(),Never>? = nil
    var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImageTask = Task {
                await setImage(from: imageSelection)
            }
        }
    }
    
    private init(userVM: UserViewProtocol = UserViewModel.shared){
        self.userVM = userVM
    }
    
    func setImage(from image: PhotosPickerItem?) async {
        guard let image else { return }
        
        do {
            if let data = try await image.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                await self.updateUserProfileImage(uiImage)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateUserProfileImage(_ uiImage: UIImage) async {
        await MainActor.run {
            if let data = uiImage.pngData() {
                // Save image data as base64 string or file path
                let base64String = data.base64EncodedString()
                userVM.updateProfilePicture(with: base64String)
            }
        }
    }
    
    func cancelTasks() {
        setImageTask?.cancel()
        setImageTask = nil
    }
}
