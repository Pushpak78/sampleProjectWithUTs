//
//  APIService.swift
//  dummy
//
//  Created by admin on 11/11/21.
//

import UIKit



class APIService {
    
    var session : URLSession!
    
    init(session: URLSession) {
            self.session = session
        }
    
    func postRequest(with userData : UserData,completion: @escaping ((_ message : String) -> Void)) {
        
        guard let url = URL(string: K.postURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = K.post
        if let postData = K.prepareData(with: userData) {
            
            request.httpBody = postData
        }
        request.allHTTPHeaderFields = K.headers
        
        let webTask = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard error == nil else {
                
                completion(error?.localizedDescription ?? K.responseError)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else { return }
            let statusCode = httpResponse.statusCode
            
            if !(K.successStatusCodesRange.contains(statusCode)){
                
                completion(K.getStatusCodeError(statusCode))
                return
            }
            if let _ = data {
                
                completion(K.success)
            }
        })
        
        webTask.resume()
    }
    
     func getRequest(completion: @escaping ((_ userRecordList : [UserRecord]?,_ message : String) -> Void)) {
        
        guard let url = URL(string: K.getURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = K.get
        request.allHTTPHeaderFields = K.headers
        let webTask = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard error == nil else {
                completion(nil,error?.localizedDescription ?? K.responseError)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else { return }
            let statusCode = httpResponse.statusCode
            
            if !(K.successStatusCodesRange.contains(statusCode)) {
                
                completion(nil, K.getStatusCodeError(statusCode))
                return
            }
            
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                do {
                    
                    let userListData = try jsonDecoder.decode(UserList.self, from: data)
                    let userRecordList = userListData.data
                    completion(userRecordList,K.success)
                } catch let responseError {
                    
                    completion(nil,responseError.localizedDescription)
                }
            }
        })
        webTask.resume()
    }
}





