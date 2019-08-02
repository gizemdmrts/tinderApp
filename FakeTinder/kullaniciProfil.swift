//
//  kullaniciProfil.swift
//  FakeTinder
//
//  Created by pearl on 23.07.2019.
//  Copyright © 2019 pearl. All rights reserved.
//


import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Kingfisher

 class kullaniciProfil: UIViewController{
    
   
    var uid = String()
    
    @IBOutlet  weak var imageViewpp: UIImageView!
    @IBOutlet  weak var adPP: UILabel!
    @IBOutlet  weak var soyad: UILabel!
    @IBOutlet  weak var ilPP: UILabel!
    @IBOutlet weak var dogumTarihi: UILabel!
    
    
    func currentprofile(){
        
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value ,with:  { (snapshot) in
                
              
                
                guard let dict = snapshot.value as? [String:Any] else {return}
                
                
                let user = current(uid: self.uid , dictionary: dict)
                
                self.adPP.text = user.adi
                self.soyad.text = user.soyadi
                self.ilPP.text = user.sehir
                self.dogumTarihi.text = user.dogumtarihi
                self.imageViewpp.kf.setImage(with: URL(string: user.resim))
                
                
            })
        }
    
        
        
        
        
    
    
   
    
     override func viewDidLoad() {
         super.viewDidLoad()
        
      
        imageViewpp.layer.cornerRadius =  imageViewpp.bounds.height / 2
        imageViewpp.clipsToBounds = true
        
       currentprofile()
        
      
    }
    
    
    

   

}
