//
//  messagepanel1.swift
//  FakeTinder
//
//  Created by pearl on 2.08.2019.
//  Copyright © 2019 pearl. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class messagepanel1: UIViewController , UITableViewDataSource , UITableViewDelegate  {
   
    
    var selectUser = User()
     var usersChat = [messagesUser]()
   
    
    @IBOutlet weak var chatTableView: UITableView!
    
    @IBOutlet weak var mynavigationItem: UINavigationItem!
    
    
    @IBOutlet weak var messagetxt: UITextField!
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  usersChat.count
      
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = chatTableView.dequeueReusableCell(withIdentifier: "chatcell", for: indexPath) as! chatCell
            let user = usersChat[indexPath.row]
        if   Auth.auth().currentUser!.uid == user.fromID{
            cell.messagesLabel.backgroundColor = UIColor.yellow
            cell.messagesLabel.text = user.text
            cell.messagesLabel.textAlignment = NSTextAlignment.right
            
           
        }
        else{
            
            cell.messagesLabel.text = user.text
            cell.messagesLabel.textAlignment = NSTextAlignment.left
            cell.messagesLabel.backgroundColor = UIColor.white
            cell.messagesLabel.adjustsFontSizeToFitWidth = true
        
        }
            return cell
    }
    
    @IBAction func bttnAction(_ sender: Any) {
        
        
        let databaseReference = Database.database().reference().child("messages")
        let childref = databaseReference.childByAutoId()
        let toID = selectUser.uid
        let fromID = Auth.auth().currentUser?.uid
        let timestamp  = NSNumber(value: Int (NSDate().timeIntervalSince1970))
        let values = ["text" : messagetxt.text! , "fromID" : fromID ,"toID" : toID , "timestamp" : timestamp ] as [String : Any]
        childref.updateChildValues(values)
        self.messagetxt.text = ""
        self.messagetxt.placeholder = "Send Message.."
       
}
    
   func chatData(){
        Database.database().reference().child("messages").observe(.childAdded, with: {(snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject]{
                
            
                let user = messagesUser()
                user.fromID = dictionary["fromID"] as! String
                user.toID = dictionary["toID"] as! String
                if (user.fromID == Auth.auth().currentUser!.uid && user.toID == self.selectUser.uid ) || (user.toID == Auth.auth().currentUser!.uid && user.fromID == self.selectUser.uid)
                {
                    user.text = dictionary["text"] as! String
                    self.usersChat.append(user)
                    self.chatTableView.reloadData()
                    
                }
               else{
                  print ("aq")
                
                }
    
            }
    
            
       
        
    })
    
}
    
    
    
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
       
        chatData()
        chatTableView.delegate = self
        chatTableView.dataSource = self
       
   self.navigationItem.title = selectUser.adi
   // let tabIcon = UIApplicationShortcutIcon(type: .message)
       // var tabItem: UITabBarItem = UITabBarItem(title: "Messages", image: , selectedImage: )
    //self.tabBarItem = tabItem
        
      
    }
    

   

}
