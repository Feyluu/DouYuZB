//
//  AnchorGroupModel.swift
//  DouYuZB
//
//  Created by DuLu on 20/06/2017.
//  Copyright © 2017 DuLu. All rights reserved.
//

import UIKit

class AnchorGroupModel: NSObject {
    // 该组中对应的房间信息
    var room_list : [[String:Any]]? {
        // 监听属性
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel.init(dict:dict as! [String : NSObject]))
            }
        }
    }
    // 组显示的标题
    var tag_name : String = ""
    // 组显示的图标
    var icon_name : String = "home_header_normal"
    // 定义主播的模型对象数组
    public lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    // MARK - 构造函数
    override init() {
        
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    // 因为返回的数据里有字段未定义相应的属性，可能会导致setValuesForKeys报错，所以重写下面的方法
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
}
