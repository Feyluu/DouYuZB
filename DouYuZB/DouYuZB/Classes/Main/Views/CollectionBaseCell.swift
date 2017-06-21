//
//  CollectionBaseCell.swift
//  DouYuZB
//
//  Created by DuLu on 21/06/2017.
//  Copyright © 2017 DuLu. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var onlineBtn: UIButton!
    
    // 定义模型属性
    public var anchor : AnchorModel? {
        didSet {
            // 校验模型是否有值
            guard let anchor = anchor else {
                return
            }
            // 显示在线人数
            var onlineStr = ""
            if anchor.online >= 10000 {
                onlineStr  = " \(Int(anchor.online/10000))万在线 "
            } else {
                onlineStr  = " \(anchor.online)万在线 "
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            // nickname
            nickNameLabel.text = anchor.nickname
            
            // 显示图片
            guard let iconUrl = NSURL(string: anchor.vertical_src) else {return}
            iconImageView.kf.setImage(with: ImageResource.init(downloadURL: iconUrl as URL))
        }
    }

}
