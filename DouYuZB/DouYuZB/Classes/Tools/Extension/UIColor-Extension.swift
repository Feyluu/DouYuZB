//
//  UIColor-Extension.swift
//  DouYuZB
//
//  Created by DuLu on 16/06/2017.
//  Copyright © 2017 DuLu. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init (r:CGFloat, g:CGFloat, b:CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}
