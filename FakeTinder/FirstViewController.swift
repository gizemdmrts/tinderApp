//
//  FirstViewController.swift
//  FakeTinder
//
//  Created by pearl on 26.06.2019.
//  Copyright © 2019 pearl. All rights reserved.
//

import UIKit
import Moya
import Firebase
import FirebaseAuth
import FirebaseDatabase
import Kingfisher


struct imageCard: Codable {
    let name, realname, team, firstappearance: String
    let createdby, publisher: String
    let imageurl: String
    let bio: String
}

class FirstViewController: UIViewController {
    var img: [imageCard] = []
    var k = 0
    var index=0
    var flag : Bool = true
    
   var imageProvider = MoyaProvider<imageNetwork>()
    
    
    @IBOutlet weak var pictureView: UIView!
    
    
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet var pangesture: UIPanGestureRecognizer!
    
    @IBOutlet weak var Likeİmage: UIImageView!
    
    
    @IBAction func pangesturerecognizer(_ sender: UIPanGestureRecognizer) {
     
       
        guard let pictureView = sender.view else {return}
        let shift = sender.translation(in: view)
        
        pictureView.center = CGPoint(x: view.center.x + shift.x, y: view.center.y + shift.y)
        
       
        
        let xDistance = pictureView.center.x - view.center.x
       
       
        
        if xDistance > 0 {
            
            
            Likeİmage.alpha=1
            Likeİmage.image = UIImage(named: "images")
            
            
            
            }
        else{
            Likeİmage.alpha = 1
            Likeİmage.image = UIImage(named: "red-31226_960_720")
          
            
        }
        
        if sender.state == UIGestureRecognizer.State.ended{
        
        Likeİmage.image = nil
         if(index < img.count-2 ){
            index+=1
            self.imageview.kf.setImage(with: URL(string: self.img[index].imageurl))
            UIView.animate(withDuration: 0.5, animations: {pictureView.center = self.view.center })
            
            }else{
            
            let alert = UIAlertController(title: "UYARI", message: "Başka kullanıcı bulunamadı.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        
             UIView.animate(withDuration: 0.5, animations: {pictureView.center = self.view.center })
            
            }
            
            
        }
       
           
        
        
        
        
    }
    
    
    
  
    @IBAction func dislikeBttn(_ sender: Any) {
        
        
    }
    
    @IBAction func likeBttn(_ sender: Any) {
        
        
        
    }
    
    
                
        
        
    

        
            
    override func viewDidLoad() {
         super.viewDidLoad()
        
        
        

        imageProvider.request(.getImage) { [weak self] result in
            guard let self = self else { return }
            
            
            switch result {
            case .success(let response):
                do {
                    
                    print(try response.mapJSON())
                    
                    let images = try JSONDecoder().decode(Array<imageCard>.self, from: response.data)
                        self.img = images
                    print(self.flag)
                   
                    while(self.k <= self.img.count-1){
                        for k in 0..<self.img.count{
                            self.imageview.kf.indicatorType = .activity
                            self.imageview.kf.setImage(with: URL(string: self.img[k].imageurl))
                            self.k+=1
                      
                       
                        
                        }
                        
                    }
                        
                    
                    
                   
                    
                    
                    
                } catch  let error{
                    
                    print(error)
                   
                }
            case .failure (let error):
                print(error)
                // 5
              
            }
        }
        
}
    

}


