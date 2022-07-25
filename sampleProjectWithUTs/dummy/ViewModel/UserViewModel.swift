//
//  UserViewModel.swift
//  dummy
//
//  Created by admin on 11/11/21.
//

import UIKit

class UserViewModel {
    
    var userData = UserData()
    var description = K.emptyString
    var message = K.emptyString
    var delegate : UserViewModelDelegate?
    var apiService : APIService
  //  var apiService = APIService(session: URLSession(configuration: .default))
    
    init(session : URLSession = URLSession(configuration: .default)){
        apiService = APIService(session: session)
    }
    func setupAPIService() {
        
        self.apiService = APIService(session: URLSession(configuration: .default))
    }
    
    func createUser() {
        
        apiService.postRequest(with : self.userData) { message in
            
            self.message = message
            self.delegate?.gotMessage(message)
        }
    }
    
    func clearUserData() {
        
        self.userData.emailAddress = K.emptyString
        self.userData.lastName = K.emptyString
        self.userData.firstName = K.emptyString
        self.message = K.emptyString
    }
    
    func isValid () -> Bool {
        
        var count = 0
        
        if self.userData.firstName.isEmpty {
            
            self.description.append(K.firstName)
            count += 1
        }
        
        if self.userData.lastName.isEmpty {
            
            if !self.description.isEmpty {
                
                self.description.append(K.comma + K.lastName)
            } else {
                
                self.description.append(K.lastName)
            }
            count += 1
        }
        
        if self.userData.emailAddress.isEmpty {
            
            if !self.description.isEmpty {
                
                self.description.append(K.comma + K.emailAddress)
            } else {
                
                self.description.append(K.emailAddress)
            }
            count += 1
        }
        if count > 0 {
            
            self.description.append(K.determine(count))
       }
        
        if count == 0 {
            
            return true
        } else {
            
            return false
        }
    }
    
    func clearDescription() {
        
        self.description = K.emptyString
    }
    
    
    func checkData(_ text : String?) -> Bool {
        
        if  let text = text {
            
            return !text.isEmpty ? K.trueValue : K.falseValue
        }
       return false
    }
    
    func setTextData(_ tag : Int, _ text : String?) {
        
        if let text = text {
            
            switch tag {
                
            case 1 : self.userData.firstName = text
            case 2 : self.userData.lastName = text
            case 3 : self.userData.emailAddress = text
            default:
                break
            }
        }
    }
}
