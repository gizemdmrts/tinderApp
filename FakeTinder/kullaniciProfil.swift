//
//  kullaniciProfil.swift
//  FakeTinder
//
//  Created by pearl on 23.07.2019.
//  Copyright © 2019 pearl. All rights reserved.
//

import UIKit

class kullaniciProfil: UIViewController {

    @IBAction func backBttn(_ sender: Any) {
        
           performSegue(withIdentifier: "back", sender: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
