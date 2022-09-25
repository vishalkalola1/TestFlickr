//
//  FlickrTests.swift
//  FlickrTests
//
//  Created by vishal on 9/25/22.
//

import XCTest
@testable import Flickr

final class SearchPhotosViewModelTests: XCTestCase {
    private var viewModel: SearchPhotosViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = SearchPhotosViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func testTitle() {
        // Given
        let expectedTitle = "Search Photos"
        
        // When
        let actualTitle = viewModel.title
        
        // Then
        XCTAssertEqual(actualTitle, expectedTitle)
    }
    
    func testPhotosCount() {
        // Given
        let expectedCount = 100
        
        // When
        var actualCount = 0
        let expectation = self.expectation(description: "waiting validation")
        let cancellable = viewModel.$photos.sink(receiveValue: { values in
            if values.count == expectedCount {
                actualCount = values.count
                expectation.fulfill()
            }
        })
        
        // Then
        wait(for: [expectation], timeout: 10)
        cancellable.cancel()
        XCTAssertEqual(expectedCount, actualCount)
    }
    
    func testSearchPhotosCount() {
        // Given
        let expectedCount = 100
        
        // When
        var actualCount = 0
        let expectation = self.expectation(description: "waiting validation")
        let cancellable = viewModel.$photos.sink(receiveValue: { values in
            if values.count == expectedCount {
                actualCount = values.count
                expectation.fulfill()
            }
        })
        
        viewModel.searchText("Test")
        
        // Then
        wait(for: [expectation], timeout: 10)
        cancellable.cancel()
        XCTAssertEqual(expectedCount, actualCount)
    }
    
    func testRecentSearchText() {
        // Given
        let expected = "Test"
        
        // When
        var actual = ""
        
        viewModel.searchText("Test")
        actual = viewModel.recentSearch.first(where: {$0 == expected })!
        
        // Then
        XCTAssertEqual(expected, actual)
    }
    
    
    func testLoadMorePhotosValidation() {

        let photo = Photo(id: "1", owner: "1", secret: "1", server: "1", farm: 1, title: "Test", ispublic: 1, isfriend: 0, isfamily: 0)
        
        // When
        let actual = viewModel.loadMorePhotos(currentItem: photo, text: "")
        
        // Then
        XCTAssertFalse(actual)
    }
    
}
