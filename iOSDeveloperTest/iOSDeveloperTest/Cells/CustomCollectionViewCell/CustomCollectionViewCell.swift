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

    @IBOutlet weak var webView: WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        webView.isOpaque = false
        let htmlFile = Bundle.main.path(forResource: "RandomChar", ofType: "html")
        let htmlString = try? String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8)
        self.webView.loadHTMLString(htmlString!, baseURL: nil)
        
    }

}
