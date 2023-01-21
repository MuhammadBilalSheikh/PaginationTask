//
//  SearchViewModelUnitTests.swift
//  MVVM-CleanTests
//
//  Created by MBS on 21/01/2023.
//

import XCTest
import Foundation
import Combine
@testable import MVVM_Clean

final class SearchViewModelUnitTests: XCTestCase, SearchDelegate {
    func reloadTableView() {
        print("reloadTableView")
    }
    
    var cancellables: [AnyCancellable] = []
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    func test_SearchUseCase_SuccessUseCase() {
        let expectation = expectation(description: "SearchUseCase_SuccessUseCase")
        let viewModelToTest: SearchViewModel = SearchViewModel(binding: self)
        viewModelToTest.searchText = "login"
        viewModelToTest.page = 1
        viewModelToTest.fetchData()?.sink( receiveCompletion: {  completion in
            switch completion {
            case .finished:
                print("Finished calling)")
            case .failure(let error):
                print("Error calling \(error)")
                XCTAssertNotNil(error.message)
                expectation.fulfill()
            }
        }, receiveValue: {response in
            print("Response Successfully parsed with \(String(describing: response))")
            if(response != nil) {
                let apiResponse =  response as! ItemsModel
                XCTAssert((apiResponse.itemsList.count != 0))
                XCTAssertNotNil(apiResponse)
                XCTAssertNil(response?.responseError)
            } else {
                XCTAssertNil(response)
                XCTAssertNil(response?.responseError)
            }
            expectation.fulfill()

            // Evaluate state here
        }).store(in: &cancellables)
        
        waitForExpectations(timeout: 5) { (error) -> Void in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }

    }
    
    func test_SearchUseCase_FailUseCase() {
        let expectation = expectation(description: "SearchUseCase_FailUseCase")
        let viewModelToTest: SearchViewModel = SearchViewModel(binding: self)
        viewModelToTest.searchText = ""
        viewModelToTest.page = 1
        viewModelToTest.fetchData()?.sink( receiveCompletion: {  completion in
            switch completion {
            case .finished:
                print("Finished calling)")
            case .failure(let error):
                print("Error calling \(error)")
                XCTAssertNotNil(error.message)
                expectation.fulfill()
            }
        }, receiveValue: {response in
            print("Response Successfully parsed with \(String(describing: response))")
            if(response != nil) {
                let apiResponse =  response as! ItemsModel
                XCTAssert((apiResponse.itemsList.count != 0))
                XCTAssertNotNil(apiResponse)
                XCTAssertNil(response?.responseError)
            } else {
                XCTAssertNil(response)
                XCTAssertNil(response?.responseError)
            }
            expectation.fulfill()

            // Evaluate state here
        }).store(in: &cancellables)
        
        waitForExpectations(timeout: 5) { (error) -> Void in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }

    }
}

