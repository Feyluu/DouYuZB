//
//  UIBarButtonItem-Extension.swift
//  DouYuZB
//
//  Created by DuLu on 15/06/2017.
//  Copyright © 2017 DuLu. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /*
    class func createItem (imageName:String, highlightedImage:String, size:CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:highlightedImage), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    */
    
    convenience init(imageName:String, highlightedImage:String, size:CGSize) {
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:highlightedImage), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        self.init(customView: btn)
    }
}
