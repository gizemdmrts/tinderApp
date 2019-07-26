//
//  currentUser.swift
//  FakeTinder
//
//  Created by pearl on 26.07.2019.
//  Copyright © 2019 pearl. All rights reserved.
//

import Foundation
struct currentUser{
    
    let uid: String
    let resim: String
    let adi: String
    let soyadi: String
    let dogumtarihi:String
    let sehir: String
    init(uid:String, dictionary: [String :Any]) {
        
        self.uid = uid
        self.adi = dictionary["adi"] as? String ?? ""
        self.soyadi = dictionary["soyadi"] as? String ?? ""
        self.dogumtarihi = dictionary["doğum tarihi"]as? String ?? ""
        self.sehir = dictionary["sehir"] as? String ?? ""
        self.resim = dictionary["resim"] as? String ?? ""
    
        
    }
    
}
