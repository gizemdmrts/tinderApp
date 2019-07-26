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

public class kullaniciProfil: UIViewController{
    
   
    
    
    @IBOutlet  weak var imageViewpp: UIImageView!
    @IBOutlet  weak var adPP: UILabel!
    @IBOutlet  weak var soyad: UILabel!
    @IBOutlet  weak var ilPP: UILabel!
    
    
    
    
    @IBAction func backBttn(_ sender: Any) {
        
           performSegue(withIdentifier: "back", sender: nil)
        
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    
    
    

   

}
