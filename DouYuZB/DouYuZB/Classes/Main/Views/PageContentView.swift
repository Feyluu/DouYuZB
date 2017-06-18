//
//  PageContentView.swift
//  DouYuZB
//
//  Created by DuLu on 16/06/2017.
//  Copyright © 2017 DuLu. All rights reserved.
//

import UIKit

fileprivate let ContentCellID = "ContentCellID"

protocol PageContentViewDelegate : class {
    func pageContentView(contentView:PageContentView, pregress:CGFloat, sourceIndex:Int, targetIndex: Int)
}

class PageContentView: UIView {
    
    fileprivate var childViewControllers : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var isForbidScrollDelegate: Bool = false
    weak var delegate : PageContentViewDelegate?
    
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
        collectionView.delegate   = self
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

// 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childViewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
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

// 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 0. 判断是不是点击事件
        if isForbidScrollDelegate {return}
        
        startOffsetX = scrollView.contentOffset.x
        
        // 1.定义需要获取的数据
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        // 2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { // 左滑
            // 2.1计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2.2计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 2.3计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childViewControllers.count {
                targetIndex = childViewControllers.count - 1
            }
            
            // 2.4如果完全划过去
            if (currentOffsetX - startOffsetX == scrollViewW) {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }
        else { // 右滑
            // 1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childViewControllers.count {
                sourceIndex = childViewControllers.count - 1
            }
            
        }
        
        // 将progress/soucce/targetIndex传递给titleView
        delegate?.pageContentView(contentView: self, pregress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}


// MARK - 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex:Int) {
        
        // 记录需要禁止直行代理方法
        isForbidScrollDelegate = true
        
        // 滑动到正确的位置
        let offSet = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offSet,y:0), animated: false)
    }
}
