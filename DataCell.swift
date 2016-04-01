//
//  Cell.swift
//  MK-App
//
//  Created by Max Gao on 17.12.15.
//  Copyright © 2015 Max Gao. All rights reserved.
//

import UIKit

class DataCell: UITableViewCell {

    
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
