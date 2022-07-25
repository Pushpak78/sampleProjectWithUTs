//
//  UserListView.swift
//  dummyTests
//
//  Created by admin on 25/11/21.
//

import XCTest
@testable import dummy

class UserListViewModelTests: XCTestCase {
    var userListViewModel : UserListViewModel!
    var session : MockURLSession! = nil

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        userListViewModel = UserListViewModel()
        session = MockURLSession()
        print("session created",session.description)
        userListViewModel.apiService = APIService(session: session)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        session = nil
    }
    
    func testGetUserListSuccessCase() {
        
        session.data = K.getUserListDataForUT()
        session.response = K.getURLResponseCode200ForUT()
        
        userListViewModel.getUserListFromAPI()
        
        XCTAssert(userListViewModel.endResult == K.trueValue)

    }
    
    func testGetUserListFailCase() {
        session.data = K.getUserListDataForUT()
        session.response = K.getURLResponseCode400ForUT()
        
        userListViewModel.getUserListFromAPI()
        
        XCTAssert(userListViewModel.endResult == K.falseValue)
        
    }
}
