//
//  UserListViewControllerTests.swift
//  dummyTests
//
//  Created by admin on 07/12/21.
//

import XCTest
@testable import dummy

class UserListViewControllerTests: XCTestCase {
    
    var sut : UserListViewController!
    var storyboard : UIStoryboard!
    var session : MockURLSession!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        session = MockURLSession()
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "UserListViewController") as UserListViewController
        sut.loadViewIfNeeded()
        sut.userListViewModel = UserListViewModel(session: session)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        session = nil
    }
    
    func testTableViewHasOutLet() throws {
        
        let _ = try XCTUnwrap(sut.tableView, "The tableView is not connected to an IBOutlet")
    }
    
    func testUserListPressedSuccessCase() {
        
        session.data = K.getUserListDataForUT()
        session.response = K.getURLResponseCode200ForUT()
        
        sut.viewDidLoad()
       
        XCTAssert(sut.userListViewModel.endResult == K.trueValue)
    }
    
    func testCreatePressedFailureCase() {
        
        session.data = K.getUserListDataForUT()
        session.response = K.getURLResponseCode400ForUT()
       
        sut.loadViewIfNeeded()
        
        XCTAssert(sut.userListViewModel.endResult == K.falseValue)
    }
    

}
