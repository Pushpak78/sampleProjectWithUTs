//
//  APIServiceTests.swift
//  dummyTests
//
//  Created by admin on 25/11/21.
//

import XCTest
@testable import dummy

class APIServiceTests: XCTestCase {

    var apiService : APIService!
    var session : MockURLSession! = nil
    //let session = MockURLSession()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
         session = MockURLSession()
        print("session created",session.description)
        apiService = APIService(session: session)
       
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        session = nil
        apiService = nil
    }
    
    func testGetApiRequestSuccessCase() {
        
        session.data = K.getUserListDataForUT()
        session.response = K.getURLResponseCode200ForUT()
    
        apiService.getRequest { userRecordList, message in
            
            XCTAssert(message == K.success)
        }
    }
    
    func testGetApiRequestFailCase() {
        
        session.data = K.getUserListDataForUT()
        session.response = K.getURLResponseCode400ForUT()
    
        apiService.getRequest { userRecordList, message in
            
            XCTAssert(message == K.getStatusCodeError(400))
        }
    }
    
    func testPostApiRequestSuccesscase() {
        
        session.data = K.getUserListDataForUT()
        session.response = K.getURLResponseCode200ForUT()
        let userData = UserData(firstName: K.firstName, lastName: K.lastName, emailAddress: K.emailAddress)
        
        apiService.postRequest(with: userData) { message in
            
            XCTAssert(message == K.success)
        }
    }
    
    func testPostApiRequestFailCase() {
        
        session.data = K.getUserListDataForUT()
        session.response = K.getURLResponseCode400ForUT()
        let userData = UserData(firstName: K.firstName, lastName: K.lastName, emailAddress: K.emailAddress)
        
        apiService.postRequest(with: userData) { message in
            
            XCTAssert(message == K.getStatusCodeError(400))
        }
    }
}
