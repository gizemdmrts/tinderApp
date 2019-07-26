//
//  profile.swift
//  FakeTinder
//
//  Created by pearl on 25.07.2019.
//  Copyright © 2019 pearl. All rights reserved.
//

import UIKit
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Kingfisher

class profile: UIViewController {
    @IBOutlet weak var profilPicture: UIImageView!
    
    @IBOutlet weak var adi: UILabel!
    @IBOutlet weak var soyadi: UILabel!
    @IBOutlet weak var sehir: UILabel!
    @IBOutlet weak var dogumtarihi: UILabel!
   
    
  
    func currentprofile(){
        if Auth.auth().currentUser != nil{
            guard let uid = Auth.auth().currentUser?.uid else{return}
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value ,with:  { (snapshot) in
                
            
                    guard let dict = snapshot.value as? [String:Any] else {return}
                    
     
            let user = current(uid: uid , dictionary: dict)
            
            self.adi.text = user.adi
            self.soyadi.text = user.soyadi
            self.sehir.text = user.sehir
            self.dogumtarihi.text = user.dogumtarihi
            self.profilPicture.kf.setImage(with: URL(string: user.resim))
            
            
                })
           }
}
        
    @IBAction func logOutbttn(_ sender: Any) {
       
        do{
            try Auth.auth().signOut()
           performSegue(withIdentifier: "logOut", sender: nil)
        }catch{
            print("Error while signing out!")
        }
       
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilPicture.layer.cornerRadius = profilPicture.frame.size.width / 2;
        profilPicture.clipsToBounds = true
        currentprofile()
        
        
      
       
        
        

    }
    

   

    }
    

