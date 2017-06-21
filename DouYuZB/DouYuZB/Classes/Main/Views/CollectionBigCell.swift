//
//  CollectionBigCell.swift
//  DouYuZB
//
//  Created by DuLu on 19/06/2017.
//  Copyright © 2017 DuLu. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionBigCell: CollectionBaseCell {
    
    @IBOutlet weak var cityBtn: UIButton!
    
    // 定义模型属性
    override var anchor : AnchorModel? {
        
        didSet {
            
            super.anchor = anchor
            
            // 所在城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
            
        }
    }

}
