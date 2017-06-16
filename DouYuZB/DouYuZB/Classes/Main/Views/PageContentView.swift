//
//  PageContentView.swift
//  DouYuZB
//
//  Created by DuLu on 16/06/2017.
//  Copyright © 2017 DuLu. All rights reserved.
//

import UIKit

fileprivate let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    fileprivate var childViewControllers : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    
    // 懒加载属性
    fileprivate lazy var collectionView:UICollectionView = { [weak self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2.创建collectionView
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    // 定义构造函数
    init(frame: CGRect, childViewControllers:[UIViewController], parentViewController:UIViewController?) {
        
        self.childViewControllers = childViewControllers
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        // 设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageContentView {
    fileprivate func setupUI() {
        // 1.将所有的子控制器添加到父控制器中
        for childVC in childViewControllers {
            parentViewController?.addChildViewController(childVC)
        }
        
        // 2.添加个UICollectionVew用于在cell中存放
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension PageContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childViewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        print(indexPath.item)
        
        // 给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVC = childViewControllers[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}

// MARK - 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex:Int) {
        let offSet = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offSet,y:0), animated: false)
    }
}
