//
//  CollectionHeaderView.swift
//  DouYuZB
//
//  Created by DuLu on 18/06/2017.
//  Copyright © 2017 DuLu. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var iconImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    
    // 定义模型属性
    var group : AnchorGroupModel? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
    
}
