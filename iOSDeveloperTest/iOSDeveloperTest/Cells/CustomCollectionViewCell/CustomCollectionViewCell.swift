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
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .random()
        self.label.text = self.randomizeAvailableLetters()
        print(self.label.text!)
    }
    
    func randomizeAvailableLetters() -> String {
        let alphabet: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        var availableTiles:String!
        let rand = Int(arc4random_uniform(26))
        availableTiles = alphabet[rand]
        return availableTiles
    }
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
