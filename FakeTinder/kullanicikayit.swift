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
import FirebaseStorage


class kullanicikayit: UIViewController , UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    @IBOutlet weak var adiTxt: UITextField!
    
    @IBOutlet weak var soyadiTxt: UITextField!
    
    @IBOutlet weak var sehirlerTxt: UITextField!
    @IBOutlet weak var bilgilabel: UILabel!
    
    let img = UIImagePickerController()
    var originalImage:UIImage? = nil
    var processedImage:UIImage? = nil
    
    
    
    
    
    let thePicker = UIPickerView()
    
    let myPickerData = [String](arrayLiteral: "", "Adana", "Adıyaman", "Afyon", "Ağrı", "Amasya", "Ankara", "Antalya", "Artvin",
                                "Aydın", "Balıkesir", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa", "Çanakkale",
                                "Çankırı", "Çorum", "Denizli", "Diyarbakır", "Edirne", "Elazığ", "Erzincan", "Erzurum", "Eskişehir",
                                "Gaziantep", "Giresun", "Gümüşhane", "Hakkari", "Hatay", "Isparta", "Mersin", "İstanbul", "İzmir",
                                "Kars", "Kastamonu", "Kayseri", "Kırklareli", "Kırşehir", "Kocaeli", "Konya", "Kütahya", "Malatya",
                                "Manisa", "Kahramanmaraş", "Mardin", "Muğla", "Muş", "Nevşehir", "Niğde", "Ordu", "Rize", "Sakarya",
                                "Samsun", "Siirt", "Sinop", "Sivas", "Tekirdağ", "Tokat", "Trabzon", "Tunceli", "Şanlıurfa", "Uşak",
                                "Van", "Yozgat", "Zonguldak", "Aksaray", "Bayburt", "Karaman", "Kırıkkale", "Batman", "Şırnak",
                                "Bartın", "Ardahan", "Iğdır", "Yalova", "Karabük", "Kilis", "Osmaniye", "Düzce")
    
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
        var uuid = NSUUID().uuidString
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child("media")
        
        if let data = imgview.image?.jpegData(compressionQuality: 0.5){
            
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
                            databaseReference.child("users").child((Auth.auth().currentUser?.uid)!).setValue(["image":imageUrl,"adi":self.adiTxt.text,"soyadi":self.soyadiTxt.text,"doğum tarihi":self.dTarihiText.text,"sehir":self.sehirlerTxt.text])
                            
                        }
                        
                    })
                }
                
            }
        }
        
        
        
       
        
        
        }
    @IBOutlet weak var imgview: UIImageView!
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    
    @objc func selectImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
        
        
    }
   
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgview.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        self.bilgilabel.isHidden = true
        
    }
    
    @IBAction func backBttn(_ sender: Any) {
        
        self.performSegue(withIdentifier: "donus", sender: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        
        imgview.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imgview.addGestureRecognizer(gestureRecognizer)
        
        super.viewDidLoad()
        
        passwordTxt.isSecureTextEntry = true
        
        sehirlerTxt.inputView = thePicker
        
        thePicker.delegate = self
        
        imgview.layer.cornerRadius =  imgview.bounds.height / 2
        imgview.clipsToBounds = true
    }
    
    
    

    }
    

