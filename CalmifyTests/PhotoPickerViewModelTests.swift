//
//  PhotoPickerViewModelTests.swift
//  CalmifyTests
//
//  Created by Rafael Loggiodice on 30/6/24.
//

import XCTest
@testable import Calmify

final class PhotoPickerViewModelTests: XCTestCase {
    
    var userMock: UserViewModelMock!
    var sut: PhotoPickerViewModel?

    override func setUpWithError() throws {
        userMock = UserViewModelMock()
        sut = PhotoPickerViewModel(userVM: userMock)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_UpdateProfileImage() async {
        guard let image = UIImage(systemName: "applelogo") else {return}
        await sut?.updateUserProfileImage(image)
        
        XCTAssertTrue(userMock.isImageUpdated)
        XCTAssertEqual(userMock.updateProfilePicture, image.pngData()?.base64EncodedString())
    }
    
}

class UserViewModelMock: UserViewProtocol {
    var isImageUpdated: Bool = false
    var updateProfilePicture: String?
    func updateProfilePicture(with base64String: String) {
        isImageUpdated = true
        updateProfilePicture = base64String
    }
}
