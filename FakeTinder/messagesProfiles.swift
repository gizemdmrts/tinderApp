//
//  messagesProfiles.swift
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



class messagesProfiles: UIViewController,UITableViewDelegate , UITableViewDataSource {
    
    
    
    @IBOutlet weak var newtableview: UITableView!
    
    
    var someProtocol = [String : String]()
    var adidata = [String]()
    
    
    func resimdata(){
        
        
        //Veritabanından resimlerin linkine çekiyoruz
        Database.database().reference().child("users").observe(DataEventType.childAdded) { (snapshot) in
            
            let values = snapshot.value! as! NSDictionary
            
            
            let resim = values["image"] as! String
            let ad = values["adi"] as! String
            let user = snapshot.key
            
            self.someProtocol[resim] = user
            self.adidata.append(ad as! String)
        //    self.newtableview.reloadData()
            
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return someProtocol.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      

      cell.myImage.kf.indicatorType = .activity
       cell.myImage.kf.setImage(with: URL(string: Array(someProtocol.keys)[indexPath.row]))

       cell.myLabel.text = self.adidata[indexPath.row]

        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

     newtableview.delegate = self

    newtableview.dataSource = self
         resimdata()
    }
    

   

}
