//
//  DogListViewModelTests.swift
//  DogAPI-iOSTests
//
//  Created by Sévio Basilio Corrêa on 24/09/25.
//

import XCTest
@testable import DogAPI_iOS

final class DogListViewModelTests: XCTestCase {
    
    // MARK: - Properties
    private var viewModel: DogListViewModel!
    private var fetchUseCaseMock: FetchRandomDogUseCaseMock!
    
    // MARK: - Setup & Teardown
    override func setUp() {
        super.setUp()
        fetchUseCaseMock = FetchRandomDogUseCaseMock()
        viewModel = DogListViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        fetchUseCaseMock = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    // Garantir que a URL retornada não é vazia
    func testFetchDogSuccess() {
        fetchUseCaseMock.shouldFail = false
        let expectation = self.expectation(description: "State changes to success")
        
        viewModel.stateChanged = { state in
            if case .success(let dog) = state {
                XCTAssertFalse(dog.imageURL.isEmpty)
                expectation.fulfill()
            }
        }
        
        viewModel.fetchDog()
        waitForExpectations(timeout: 1)
    }
    
    func testLastDogIsUpdatedAfterFetch() {
        let expectation = self.expectation(description: "lastDog is updated")
        
        viewModel.stateChanged = { state in
            if case .success = state {
                XCTAssertNotNil(self.viewModel.lastDog)
                expectation.fulfill()
            }
        }
        
        viewModel.fetchDog()
        waitForExpectations(timeout: 5)
    }
    
    func testStateChangesToLoadingBeforeSuccess() {
        var states: [DogListViewModel.ViewState] = []
        let expectation = self.expectation(description: "State changes are tracked")
        
        viewModel.stateChanged = { state in
            states.append(state)
            if states.count == 2 {
                XCTAssertTrue(states.first == .loading)
                XCTAssertTrue({
                    if case .success = states.last! { return true }
                    return false
                }())
                expectation.fulfill()
            }
        }
        
        viewModel.fetchDog()
        waitForExpectations(timeout: 5)
    }

}
