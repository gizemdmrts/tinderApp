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


struct imageCard: Decodable {
    let name, realname, team, firstappearance: String
    let createdby, publisher: String
    let imageurl: String
    let bio: String
}

class FirstViewController: UIViewController {
    var img: [imageCard]?
    let count = 0
    
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
        
        if xDistance > 0{
            Likeİmage.alpha=1
            Likeİmage.image = UIImage(named: "images")
            imageview.kf.setImage(with:img[count], placeholder: nil, options: <#T##KingfisherOptionsInfo?#>, progressBlock: <#T##DownloadProgressBlock?##DownloadProgressBlock?##(Int64, Int64) -> Void#>, completionHandler: <#T##((Result<RetrieveImageResult, KingfisherError>) -> Void)?##((Result<RetrieveImageResult, KingfisherError>) -> Void)?##(Result<RetrieveImageResult, KingfisherError>) -> Void#>)
            
            }
        else{
            Likeİmage.alpha = 1
            Likeİmage.image = UIImage(named: "red-31226_960_720")
            
            
        }
        
        if sender.state == UIGestureRecognizer.State.ended{
            UIView.animate(withDuration: 0.5, animations: {pictureView.center = self.view.center })
            self.Likeİmage.alpha = 0
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
                   
                    
                        print(images)
                    
                   
                    
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


