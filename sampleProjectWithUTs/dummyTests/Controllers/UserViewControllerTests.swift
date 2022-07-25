//
//  UserViewControllerTests.swift
//  dummyTests
//
//  Created by admin on 29/11/21.
//

import XCTest
@testable import dummy

class UserViewControllerTests: XCTestCase {
    
    var sut : UserViewController!
    var storyboard : UIStoryboard!
    var session : MockURLSession!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        session = MockURLSession()
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "UserViewController") as UserViewController
        sut.loadViewIfNeeded()
        sut.userViewModel = UserViewModel(session: session)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut.userViewModel.clearDescription()
        sut.userViewModel.clearUserData()
        session = nil
    }
    
    func testTextFieldsEmpty() throws {
        
        let firstNameTextField = try XCTUnwrap(sut.firstNameTextField, "The firstNameTextField is not connected to an IBOutlet")
        let lastNameTextField = try XCTUnwrap(sut.lastNameTextField, "The lastNameTextField is not connected to an IBOutlet")
        let emailTextField = try XCTUnwrap(sut.emailTextField, "The emailTextField is not connected to an IBOutlet")
        
        XCTAssertEqual(firstNameTextField.text, "", "First name text field was not empty when the view controller initially loaded")
        XCTAssertEqual(lastNameTextField.text, "", "Last name text field was not empty when the view controller initially loaded")
        XCTAssertEqual(emailTextField.text, "", "Email text field was not empty when the view controller initially loaded")
    }
    
    func testViewController_WhenCreated_HasSignupButtonAndAction() throws {
        // Arrange
        let createButton: UIButton = try XCTUnwrap(sut.createButton, "Signup button does not have a referencing outlet")
        
        // Act
        let createButtonActions = try XCTUnwrap(createButton.actions(forTarget: sut, forControlEvent: .touchUpInside), "create button does not have any actions assigned to it")

        // Assert
        XCTAssertEqual(createButtonActions.count, 1)
        XCTAssertEqual(createButtonActions.first, "createPressed:", "There is no action with a name createButtonTapped assigned to create button")
    }
    
    func testCreatePressedSuccessCase() {
        
        sut.userViewModel.userData = UserData(firstName: K.firstName, lastName: K.lastName, emailAddress: K.emailAddress)
        session.data = K.getUserListDataForUT()
        session.response = K.getURLResponseCode200ForUT()
        
        // Act
       
        sut.createButton.sendActions(for: .touchUpInside)
        
        // Assert
        XCTAssert(sut.userViewModel.message == K.success)
        
    }
    
    func testCreatePressedFailureCase() {
        
        sut.userViewModel.userData = UserData(firstName: K.firstName, lastName: K.lastName, emailAddress: K.emailAddress)
        session.data = K.getUserListDataForUT()
        session.response = K.getURLResponseCode400ForUT()
        
        // Act
       
        sut.createButton.sendActions(for: .touchUpInside)
        
        // Assert
        XCTAssert(sut.userViewModel.message == K.getStatusCodeError(400))
        
    }
}
