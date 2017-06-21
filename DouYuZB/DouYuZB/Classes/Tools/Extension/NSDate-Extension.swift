//
//  NSDate-Extension.swift
//  DouYuZB
//
//  Created by DuLu on 20/06/2017.
//  Copyright © 2017 DuLu. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowTime = NSDate()
        let interval = nowTime.timeIntervalSince1970
        return "\(interval)"
    }
}
