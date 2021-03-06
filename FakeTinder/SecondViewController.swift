//
//  SecondViewController.swift
//  FakeTinder
//
//  Created by pearl on 26.06.2019.
//  Copyright © 2019 pearl. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Kingfisher



 class SecondViewController:UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var mycollectionview: UICollectionView!
   
  
    
    var someProtocol = [String : String]()
    
     func resimdata(){
        
        
        //Veritabanından resimlerin linkine çekiyoruz
        Database.database().reference().child("users").observe(DataEventType.childAdded) { (snapshot) in
            
        let values = snapshot.value! as! NSDictionary
            
            if snapshot.key != Auth.auth().currentUser!.uid {
                
                let resim = values["image"] as! String
                let user = snapshot.key
            
            
                self.someProtocol[resim] = user
            
                self.mycollectionview.reloadData()
                
            }
            
        }
            
    }
        
        
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        
     performSegue(withIdentifier: "profilepath", sender: someProtocol[Array(someProtocol.keys)[indexPath.row]])
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profilepath" {
            if let viewController = segue.destination as? kullaniciProfil {
                viewController.uid = (sender as? String)!
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        
        return someProtocol.count
    }
    
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCell
    
        cell.myImageView.kf.indicatorType = .activity
    
        cell.myImageView.kf.setImage(with: URL(string: Array(someProtocol.keys)[indexPath.row]))
        
        cell.myImageView.isUserInteractionEnabled = true
    
        return cell
    }
    
  
 
        
    
    
    
   
    
  
  
    
 
    

   
    override func viewDidLoad() {
       
       
        super.viewDidLoad()
        resimdata()
        
        let itemsize = UIScreen.main.bounds.width/3-3
        let layout = UICollectionViewFlowLayout()

        let sectioninset = UIEdgeInsets(top: 20,left: 20,bottom: 20,right: 20)
        layout.itemSize = CGSize(width: itemsize, height: itemsize)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        
        mycollectionview.collectionViewLayout = layout
        mycollectionview.delegate = self
        mycollectionview.dataSource = self
        
      
       
        
        }
    
  
    
    
}

