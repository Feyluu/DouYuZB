//
//  PageContentView.swift
//  DouYuZB
//
//  Created by DuLu on 16/06/2017.
//  Copyright © 2017 DuLu. All rights reserved.
//

import UIKit

class PageContentView: UIView {
    
    fileprivate var childViewControllers : [UIViewController]
    fileprivate var parentViewController : UIViewController
    
    init(frame: CGRect, childViewControllers:[UIViewController], parentViewController:UIViewController) {
        self.childViewControllers = childViewControllers
        self.parentViewController = parentViewController
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
