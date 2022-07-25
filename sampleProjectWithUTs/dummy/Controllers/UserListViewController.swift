//
//  UserListViewController.swift
//  dummy
//
//  Created by admin on 11/11/21.
//

import UIKit
import Combine

class UserListViewController : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var userListViewModel = UserListViewModel()
    private var subscriptions = Set<AnyCancellable>()
    private var subscriptions1 = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        userListViewModel.getUserListFromAPI()
        self.updateUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
         subscriptions.removeSubscriptions()
         subscriptions1.removeSubscriptions()
    }
   
    func updateUI() {
        
        userListViewModel.$userRecordList.sink { _ in
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
        }.store(in: &subscriptions)
        
        userListViewModel.$errorMessage.sink { message in
            
            if let message = message {
                
                self.showPopUp(with: message, identifier: "Success")
            }
        }.store(in: &subscriptions1)
    }
}

extension UserListViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userListViewModel.userRecordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        if let firstNameLabel = cell.viewWithTag(K.firstNameTag) as? UILabel {
            
            firstNameLabel.text = userListViewModel.userRecordList[indexPath.row].firstName
        }
        if let lastNameLabel = cell.viewWithTag(K.lastNameTag) as? UILabel {
            
            lastNameLabel.text = userListViewModel.userRecordList[indexPath.row].lastName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return K.cellHeight
    }
}
