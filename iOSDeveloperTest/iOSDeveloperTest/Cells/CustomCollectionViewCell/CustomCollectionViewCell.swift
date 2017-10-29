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
    var colorField:String = "#5086eb"
    var stringField:String = "Y"
//    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var webView: UIWebView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setData(data:NSDictionary) {
        self.webView.scrollView.isScrollEnabled = false; 
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, -10, 0, 0)
        let color = data.object(forKey: "Color") as! UIColor
        colorField = color.htmlRGB
        print(colorField)
        stringField = data.object(forKey: "String") as! String
        let htmlStr = "<!DOCTYPE html><html><head><style>.container{position: absolute;top: 0;bottom: 0;width: 100%;background-color: \(colorField);}.center{position:absolute;height: X px;width: Y px;left:50%;top:50%;margin-top:- X/2 px;margin-left:- Y/2 px;text-shadow: black 0.01em 0.01em 0.01em}</style></head><body><div class = 'container' ><h2 class = 'center' > \(stringField) </h1></div></body></html>"
        self.webView.loadHTMLString(htmlStr, baseURL: nil)
    }
    

}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            return (r,g,b,a)
        }
        return (0, 0, 0, 0)
    }
    
    // hue, saturation, brightness and alpha components from UIColor**
    var hsba: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return (hue, saturation, brightness, alpha)
        }
        return (0,0,0,0)
    }
    
    var htmlRGB: String {
        return String(format: "#%02x%02x%02x", Int(rgba.red * 255), Int(rgba.green * 255), Int(rgba.blue * 255))
    }
    
    var htmlRGBA: String {
        return String(format: "#%02x%02x%02x%02x", Int(rgba.red * 255), Int(rgba.green * 255), Int(rgba.blue * 255), Int(rgba.alpha * 255) )
    }
}
