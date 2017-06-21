//
//  CollectionNormalCell.swift
//  DouYuZB
//
//  Created by DuLu on 18/06/2017.
//  Copyright © 2017 DuLu. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNormalCell: CollectionBaseCell {


    @IBOutlet weak var roomName: UILabel!
    
    override var anchor : AnchorModel? {
        
        didSet {
            
            super.anchor = anchor
            
            // 显示房间名称
            roomName.text = anchor?.room_name
        
        }
    }
    
}
