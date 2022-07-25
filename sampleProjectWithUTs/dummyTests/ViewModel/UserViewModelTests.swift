//
//  UserViewTests.swift
//  dummyTests
//
//  Created by admin on 25/11/21.
//

import XCTest
@testable import dummy

class UserViewModelTests: XCTestCase {
    
    var userViewModel : UserViewModel!
    var session : MockURLSession! = nil

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        userViewModel = UserViewModel()
        session = MockURLSession()
        print("session created",session.description)
        userViewModel.apiService = APIService(session: session)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        userViewModel.clearDescription()
        userViewModel.clearUserData()
        session = nil
    }

    // MARK: UserViewModel isValid method TestCases
    
    func testCheckDescriptionWithFirstnameAndLastnameEmpty() {
        
        userViewModel.userData.firstName = K.emptyString
        userViewModel.userData.lastName = K.emptyString
        userViewModel.userData.emailAddress = K.emailAddress
        
         let flag = userViewModel.isValid()
        
        XCTAssert(flag == K.falseValue)
        XCTAssert(userViewModel.description == K.firstUTResult, K.isValidUTErrorMessage)
    }
    
    func testCheckdescriptionWithLastnameEmpty() {
        
        userViewModel.userData.firstName = K.firstName
        userViewModel.userData.lastName = K.emptyString
        userViewModel.userData.emailAddress = K.emailAddress
        
        let flag = userViewModel.isValid()
        
        XCTAssert(flag == K.falseValue)
        XCTAssert(userViewModel.description == K.secondUTResult, K.isValidUTErrorMessage)
    }
    
    func testCheckDescriptionWithfirstNameEmpty() {
        
        userViewModel.userData.firstName = K.emptyString
        userViewModel.userData.lastName = K.lastName
        userViewModel.userData.emailAddress = K.emailAddress
        
        let flag = userViewModel.isValid()
        
        XCTAssert(flag == K.falseValue)
        XCTAssert(userViewModel.description == K.thirdUTResult, K.isValidUTErrorMessage)
    }
    
    func testCheckDescriptionWithUserDataEmpty() {
        
        userViewModel.userData.firstName = K.emptyString
        userViewModel.userData.lastName = K.emptyString
        userViewModel.userData.emailAddress = K.emptyString
        
        let flag = userViewModel.isValid()
        
        XCTAssert(flag == K.falseValue)
        XCTAssert(userViewModel.description == K.fourthUTResult, K.isValidUTErrorMessage)
    }
    
    func testCheckWithValidUserData() {
        
        userViewModel.userData.firstName = K.firstName
        userViewModel.userData.lastName = K.lastName
        userViewModel.userData.emailAddress = K.emailAddress
        
        let flag = userViewModel.isValid()
        
        XCTAssert(flag == K.trueValue)
        XCTAssert(userViewModel.description == K.emptyString, K.isValidUTErrorMessage)
    }
    
    // MARK: userViewModel checkData() TestCases
    
    func testCheckDataWithValidAndInvalidData() {
        
        var data : String? = nil
        
        var flag = userViewModel.checkData(data)
        
        XCTAssert(flag == K.falseValue)
        
        data = K.emailAddress
        
        flag = userViewModel.checkData(data)
        
        XCTAssert(flag == K.trueValue)
    }
    
    // MARK: userViewModel setTextData () TestCase
    
    func testSetTextData() {
        
        XCTAssert(userViewModel.userData.firstName == K.emptyString)
        
        userViewModel.setTextData(K.firstNameTag, K.firstName)
        XCTAssert(userViewModel.userData.firstName == K.firstName)
        
        XCTAssert(userViewModel.userData.lastName == K.emptyString)
        
        userViewModel.setTextData(K.lastNameTag, K.lastName)
        XCTAssert(userViewModel.userData.lastName == K.lastName)
        
        XCTAssert(userViewModel.userData.emailAddress == K.emptyString)
        
        userViewModel.setTextData(K.emailAddressTag, K.emailAddress)
        XCTAssert(userViewModel.userData.emailAddress == K.emailAddress)
    }
    
    // MARK : userViewModel createUser() TestCase
    
    func testCreateUserSuccessCase() {
        
        userViewModel.userData.firstName = K.firstName
        userViewModel.userData.lastName = K.lastName
        userViewModel.userData.emailAddress = K.emailAddress
        
        session.data = K.getUserListDataForUT()
        session.response = K.getURLResponseCode200ForUT()
        
        userViewModel.createUser()
        
        XCTAssert(userViewModel.message == K.success)
    }
    
    func testCreateUserfailCase() {
        
        userViewModel.userData.firstName = K.firstName
        userViewModel.userData.lastName = K.lastName
        userViewModel.userData.emailAddress = K.emailAddress
        
        session.data = K.getUserListDataForUT()
        session.response = K.getURLResponseCode400ForUT()
        
        userViewModel.createUser()
        
        XCTAssert(userViewModel.message == K.getStatusCodeError(400))
    }
}


