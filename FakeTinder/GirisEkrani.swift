//
//  GirisEkranı.swift
//  FakeTinder
//
//  Created by pearl on 26.06.2019.
//  Copyright © 2019 pearl. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class GirisEkrani: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    
    
    @IBAction func girisYap(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (userdata, error) in
                if error != nil{
                    let alert = UIAlertController(title: " error ", message:error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert,animated: true)
                }
            
            else{
                   self.performSegue(withIdentifier: "singIn", sender: nil)
               //kullanıcıhatırlama kodları.
                    //UserDefaults.standard.set(userdata?.user.email, forKey: "user")
                        //UserDefaults.standard.synchronize()
                   // let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    //delegate.rememberUser()
                    
                    
                
                }
           
            }
        
        
        }
        
        else{ let alert = UIAlertController(title: " error ", message:"error"  , preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert,animated: true)
            
        }
        
    }
   
    
    @IBAction func kayitOl(_ sender: Any) {
        
        performSegue(withIdentifier: "kayit", sender: nil)
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        passwordText.isSecureTextEntry = true
        
    }
    

   

}
