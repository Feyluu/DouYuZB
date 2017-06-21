//
//  AnchorModel.swift
//  DouYuZB
//
//  Created by DuLu on 20/06/2017.
//  Copyright © 2017 DuLu. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    // 房间ID
    var room_id : Int = 0
    // 房间图片对应的图片url
    var vertical_src : String = ""
    // 判断是手机直播还是电脑直播
    var isVertical : Int = 0
    // 房间名称
    var room_name : String = ""
    // 昵称
    var nickname : String = ""
    // 观看人数
    var online : Int = 0
    // 城市
    var anchor_city : String = ""
    
    init(dict: [String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    // 因为返回的数据里有字段未定义相应的属性，可能会导致setValuesForKeys报错，所以重写下面的方法
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
