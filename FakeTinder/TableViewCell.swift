//
//  TableViewCell.swift
//  FakeTinder
//
//  Created by pearl on 18.07.2019.
//  Copyright © 2019 pearl. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import SwiftKeychainWrapper

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var sohbetOnizleme: UILabel!
    
    var messageDetail : messageDetail!
    var userPostKey :  DatabaseReference!
    
  var currentUser = KeychainWrapper.standard.string(forKey: "uid")
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configurecell(messageDetail : messageDetail){
        self .messageDetail = messageDetail
        let recipientData = Database.database().reference().child("users").child(messageDetail.recipient)
        recipientData.observeSingleEvent(of: .value, with: {(snapshot) in
            
            let data = snapshot.value as! Dictionary <String ,AnyObject>.Element
            let userName = data ["username"]
            self.namelabel.text = username as? String
            
        })
    }

}
