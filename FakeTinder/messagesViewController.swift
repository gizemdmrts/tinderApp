//
//  messagesViewController.swift
//  FakeTinder
//
//  Created by pearl on 1.08.2019.
//  Copyright © 2019 pearl. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Kingfisher

class messagesViewController: UIViewController,UITableViewDelegate , UITableViewDataSource {
   
    
   
    
    
    
    @IBOutlet weak var tableviewpp: UITableView!
    var someProtocol = [String : String ]()
    var adiArray = [String]()
    var users = [User]()
   
    
    func resimdata(){
        Database.database().reference().child("users").observe(.childAdded, with: {(snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject]{
                
            let user = User()
                user.adi = dictionary["adi"] as! String
                user.image = dictionary["image"] as! String
                user.uid = snapshot.key
                if user.uid != Auth.auth().currentUser!.uid {
                
                self.users.append(user)
                    self.tableviewpp.reloadData()
                    
                }
                
            }
            
            
        }, withCancel: nil)
}
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         performSegue(withIdentifier: "messagePath", sender: users[indexPath.row] )
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "messagePath" {
            if let viewController = segue.destination as? messagepanel1 {
                viewController.selectUser = (sender) as! User
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableviewpp.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! tableview
       let user = users[indexPath.row]
        if user.uid != Auth.auth().currentUser!.uid {
        cell.mylabelpp.text = user.adi
        cell.myimagepp.kf.indicatorType = .activity
        
            cell.myimagepp.kf.setImage(with: URL(string: user.image!))
            
        }
        return cell
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        resimdata()
        
        tableviewpp.delegate = self
        tableviewpp.dataSource = self
}
    

   

}
