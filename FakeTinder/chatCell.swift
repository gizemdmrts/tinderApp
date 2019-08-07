//
//  chatCell.swift
//  FakeTinder
//
//  Created by pearl on 5.08.2019.
//  Copyright © 2019 pearl. All rights reserved.
//

import UIKit

class chatCell: UITableViewCell {
    
    @IBOutlet weak var gelenmessage: UILabel!
    @IBOutlet weak var gelenview: UIView!
    
    @IBOutlet weak var gidenmessage: UILabel!
    @IBOutlet weak var gidenview: UIView!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
