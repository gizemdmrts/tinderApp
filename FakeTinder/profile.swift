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

class profile: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var profilPicture: UIImageView!
    
    @IBOutlet weak var adi: UILabel!
    @IBOutlet weak var soyadi: UILabel!
    @IBOutlet weak var sehir: UILabel!
    @IBOutlet weak var dogumtarihi: UILabel!
    
    var useruid = Auth.auth().currentUser!.uid
    
    @IBAction func editButton(_ sender: Any) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
        
        
        
        
                
    }
    
            
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                profilPicture.image = info[.originalImage] as? UIImage
                let uuid = NSUUID().uuidString
                
                let storage = Storage.storage()
                let storageRef = storage.reference()
                let mediaFolder = storageRef.child("media")
                
                if let data = profilPicture.image?.jpegData(compressionQuality: 0.5){
                    
                    let mediaImages = mediaFolder.child("\(uuid).jpg")
                    mediaImages.putData(data, metadata: nil)    { (metadata,error) in
                        if error != nil{
                            let alert = UIAlertController(title: " error ", message:error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                            let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
                            alert.addAction(okButton)
                            self.present(alert,animated: true)
                            
                        }
                        else{
                            mediaImages.downloadURL(completion: {(url,error) in
                                if error == nil{
                                    
                                    let imageUrl = url?.absoluteString
                                    let databaseReference = Database.database().reference()
                                    
                                    
                                    databaseReference.child("users").child((Auth.auth().currentUser?.uid)!).updateChildValues(["image" : imageUrl])
                                                                self.profilPicture.kf.indicatorType = .activity
                                                                self.profilPicture.kf.setImage(with: url)
                                    
                                }
                                
                            })
                        }
                        
                    }
                }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
  
    func currentprofile(){
        if Auth.auth().currentUser != nil{
            guard let uid = Auth.auth().currentUser?.uid else{return}
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value ,with:  { (snapshot) in
                
            
                    guard let dict = snapshot.value as? [String:Any] else {return}
                    
     
            let user = current(uid:uid , dictionary: dict)
            
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
       
        profilPicture.layer.cornerRadius =  profilPicture.bounds.height / 2
       profilPicture.clipsToBounds = true
        
        currentprofile()
        }
    


}

