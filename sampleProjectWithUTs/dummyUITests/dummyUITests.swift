//
//  dummyUITests.swift
//  dummyUITests
//
//  Created by OMNIADMIN on 25/07/22.
//

import XCTest

class dummyUITests: XCTestCase {
    
    private var app : XCUIApplication!
    private var firstNameTextField: XCUIElement!
    private var lastNameTextField: XCUIElement!
    private var emailTextField: XCUIElement!
    private var createButton: XCUIElement!
    private var userListButton: XCUIElement!

    override func setUpWithError() throws {
        
        try super.setUpWithError()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
        
        firstNameTextField = app.textFields["firstName"]
        lastNameTextField = app.textFields["lastName"]
        emailTextField = app.textFields["email"]
        createButton = app.buttons["create"]
        userListButton = app.buttons["userList"]
    }

    override func tearDownWithError() throws {
        
        firstNameTextField = nil
        lastNameTextField = nil
        emailTextField = nil
        createButton = nil
        userListButton = nil
        app = nil
        
        try super.tearDownWithError()
    }
    
    func testAreAllElementsEnabledCase() throws {
        
        XCTAssertTrue(firstNameTextField.isEnabled, "firstName textfield is not enabled")
        XCTAssertTrue(lastNameTextField.isEnabled, "lastNameTextField is not enabled")
        XCTAssertTrue(emailTextField.isEnabled, "emailTextField is not enabled")
        XCTAssertTrue(createButton.isEnabled, "createButton is not enabled")
        XCTAssertTrue(userListButton.isEnabled, "userListButton is not enabled")
    }
    

    func testCreateSuccessCase() throws {
        
        firstNameTextField.tap()
        firstNameTextField.typeText("weang")
        
        lastNameTextField.tap()
        lastNameTextField.typeText("Wulin")
        
        emailTextField.tap()
        emailTextField.typeText("tancwfwulin@gmail.com")
        
        firstNameTextField.tap()
        
        createButton.tap()
        XCTAssertTrue(app.alerts["Success"].waitForExistence(timeout: 2)  , "Create user functionality is failing")
    }
    
    func testCreateFailureCase() throws {
        
        firstNameTextField.tap()
        firstNameTextField.typeText("Tang")
        
        lastNameTextField.tap()
        lastNameTextField.typeText("Wulin")
        
        
        createButton.tap()
        XCTAssertTrue(app.alerts["failure"].waitForExistence(timeout: 2)  , "Create user functionality is failing")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
