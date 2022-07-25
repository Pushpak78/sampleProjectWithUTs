//
//  UserListViewModel.swift
//  dummy
//
//  Created by admin on 12/11/21.
//

import Foundation
import Combine

class UserListViewModel : ObservableObject {
    
    @Published var userRecordList : [UserRecord] = []
    @Published var errorMessage : String? = nil
    var endResult = false
    var apiService : APIService
  //  var apiService = APIService(session: URLSession(configuration: .default))
    
    init(session : URLSession = URLSession(configuration: .default)){
        apiService = APIService(session: session)
    }
    
    func getUserListFromAPI() {
        
        apiService.getRequest() { (userList,message) in
            
            if let userList = userList {
                
                self.endResult = true
                self.userRecordList = userList
            } else {
                
                self.endResult = false
                self.errorMessage = message
            }
        }
    }
}
