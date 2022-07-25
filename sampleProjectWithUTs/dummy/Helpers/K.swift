//
//  K.swift
//  dummy
//
//  Created by admin on 11/11/21.
//

import UIKit
import Combine

typealias RemoveSubscription = Set<AnyCancellable>

struct K {
    
    static let postURL = "https://dummyapi.io/data/v1/user/create"
    static let getURL = "https://dummyapi.io/data/v1/user?created=1"
    static let post = "POST"
    static let get = "GET"
    static let responseError = "Resposne Error"
    static let serverError = "server data error"
    static let success = "Success"
    static let headers = ["app-id" : "618cbaff05c591391ca035ff"]
    static let cellIdentifier = "usercell"
    static let firstNameTag = 1
    static let lastNameTag = 2
    static let emailAddressTag = 3
    static let cellHeight = CGFloat(100)
    static let successStatusCodesRange = 200...299
    static let emptyString = ""
    static let notificationText = "Notification"
    static let ok = "Ok"
    static let trueValue = true
    static let falseValue = false
    static let firstName = "FirstName"
    static let lastName = " LastName"
    static let emailAddress = " EmailAddress"
    static let missingText = " missing"
    static let comma = ","
    
    // For UTs
    static let firstUTResult = "FirstName, LastName are missing"
    static let secondUTResult = " LastName is missing"
    static let thirdUTResult = "FirstName is missing"
    static let fourthUTResult = "FirstName, LastName, EmailAddress are missing"    
    static let isValidUTErrorMessage = "Someone changed in userViewModel.isValid method"
    
    static let dummyUserList = [ UserRecord(firstName: K.firstName, lastName: K.lastName),
                                UserRecord(firstName: K.firstName, lastName: K.lastName),
                                UserRecord(firstName: K.firstName, lastName: K.lastName),
                                UserRecord(firstName: K.firstName, lastName: K.lastName),
                                UserRecord(firstName: K.firstName, lastName: K.lastName),
                                UserRecord(firstName: K.firstName, lastName: K.lastName)
    ]
    
    
   static func getUserListDataForUT() -> Data? {
        
        var  userlist = UserList(data: K.dummyUserList)
        let encoder = JSONEncoder()
      //  encoder.outputFormatting = .prettyPrinted
        let orderJsonData = try? encoder.encode(userlist)
        return orderJsonData
        
       // print(String(data: orderJsonData, encoding: .utf8)!)
    }
    
    static func getURLResponseCode200ForUT() -> HTTPURLResponse? {
        
        let response = HTTPURLResponse(url: URL(string: K.getURL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        return response
    }
    
    static func getURLResponseCode400ForUT() -> HTTPURLResponse? {
        
        let response = HTTPURLResponse(url: URL(string: K.getURL)!, statusCode: 400, httpVersion: nil, headerFields: nil)
        
        return response
    }
    
    
    static func determine(_ count : Int) -> (String) {
        
        return (count == 1) ? " is missing" : " are missing"
    }
   
    static func prepareData(with model : UserData) -> Data? {
        
       return     "firstName=\(model.firstName)&lastName=\(model.lastName)&email=\(model.emailAddress)".data(using: .utf8)
    }
    
    static func getStatusCodeError(_ code : Int) -> String {
        
        return "Recieved \(code) from API"
    }
}

extension UIViewController {
    
    func showPopUp(with message : String, identifier : String) {
        
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: K.notificationText, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: K.ok, style: UIAlertAction.Style.default, handler: nil))
            alert.view.accessibilityIdentifier = identifier
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension RemoveSubscription {
    
    mutating func removeSubscriptions() {
        
        forEach { $0.cancel() }
        removeAll()
    }
}
