//
//  PhotoPickerViewModelTests.swift
//  CalmifyTests
//
//  Created by Rafael Loggiodice on 30/6/24.
//

import XCTest
@testable import Calmify

final class PhotoPickerViewModelTests: XCTestCase {
    
    var sut: PhotoPickerViewModel?

    override func setUpWithError() throws {
        sut = PhotoPickerViewModel.shared
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
}
