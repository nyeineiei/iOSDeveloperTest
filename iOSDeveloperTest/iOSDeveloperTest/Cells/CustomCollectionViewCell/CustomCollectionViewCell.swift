//
//  CustomCollectionViewCell.swift
//  iOSDeveloperTest
//
//  Created by Moe Han on 10/27/17.
//  Copyright © 2017 NyeinEi. All rights reserved.
//

import UIKit
import WebKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var position: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setData(data:NSDictionary) {
        self.backgroundColor = data.object(forKey: "Color") as? UIColor
        self.label.text = data.object(forKey: "String") as? String
    }
}
