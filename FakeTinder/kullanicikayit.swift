//
//  kullanicikayit.swift
//  FakeTinder
//
//  Created by pearl on 27.06.2019.
//  Copyright © 2019 pearl. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class kullanicikayit: UIViewController , UIPickerViewDataSource,UIPickerViewDelegate{
    
    
    @IBOutlet weak var adiTxt: UITextField!
    
    @IBOutlet weak var soyadiTxt: UITextField!
    
    @IBOutlet weak var sehirlerTxt: UITextField!
    
    let thePicker = UIPickerView()
    
    let myPickerData = [String](arrayLiteral: "Adana", "Ankara", "Antalya", "istanbul", "İzmir", "Mersin")
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData.count
    }
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerData[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sehirlerTxt.text = myPickerData[row]
    }
   
    
    @IBOutlet weak var dTarihiText: UITextField!
    
    
    
    @IBOutlet weak var emailTxt: UITextField!
    
   
    
    @IBOutlet weak var passwordTxt: UITextField!
    
   
    @IBAction func dTarihi(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
    }
    
   
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        
        
        dTarihiText.text = dateFormatter.string(from: sender.date)
        
    }
    
   
    @IBAction func kayitOl(_ sender: Any) {
        if emailTxt.text != "" && passwordTxt.text != "" {
            Auth.auth().createUser(withEmail: emailTxt.text!, password: passwordTxt.text!){
                (userdata,error) in
                if error != nil{
                    let alert = UIAlertController(title: "error ", message:error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert,animated: true)
                    
                }
                else {
                    self.performSegue(withIdentifier: "donus", sender: nil)
                }
            }
            
        }
            
            
        else {   let alert = UIAlertController(title: "error", message:"Hatalı bilgi girdiniz." , preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert,animated: true)
            
        }
        
       
     
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        passwordTxt.isSecureTextEntry = true
        
        sehirlerTxt.inputView = thePicker
        
        thePicker.delegate = self
       
     
    }
    
    

    }
    

