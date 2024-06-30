//
//  CalmifyTests.swift
//  CalmifyTests
//
//  Created by Rafael Loggiodice on 30/6/24.
//

import XCTest
@testable import Calmify
import SwiftUI

final class UserViewModelTests: XCTestCase {

    var sut: UserViewModel?
    
    override func setUpWithError() throws {
        sut = UserViewModel.shared
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_Selecting_EmptyProfileImage() {
        sut?.removeProfilePicture()
        XCTAssertEqual(sut?.imageProfile, Image(systemName: "person.circle.fill"))
    }
    
    func test_Selecting_DataProfileImage() {
        let validBase64String = "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/wcAAgMBAFGaAXsAAAAASUVORK5CYII="

        guard let data = Data(base64Encoded: validBase64String) else {
            XCTFail("Failed to create Data from base64 string")
            return
        }
        let imageWithData = data.base64EncodedString()
        sut?.updateProfilePicture(with: imageWithData)
        
        XCTAssertEqual(sut?.userData.profilePicture, validBase64String)
    }
    
    func test_Selecting_Default_ProfileImage() {
        sut?.userData.profilePicture = "foto"
        let image = sut?.imageProfile
        
        XCTAssertEqual(image, Image("foto"))
    }
    
    func test_RemoveProfilePicture() {
        sut?.removeProfilePicture()
        XCTAssertEqual(sut?.userData.profilePicture, "")
    }

    func test_UpdateProfilePicture_WithString() {
        sut?.updateProfilePicture(with: "nuevaFoto")
        XCTAssertEqual(sut?.userData.profilePicture, "nuevaFoto")
    }

}
