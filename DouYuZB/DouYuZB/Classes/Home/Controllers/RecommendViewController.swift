//
//  RecommendViewController.swift
//  DouYuZB
//
//  Created by DuLu on 18/06/2017.
//  Copyright © 2017 DuLu. All rights reserved.
//

import UIKit

fileprivate let kItemMargin : CGFloat = 10
fileprivate let kItemW = (kScreenW - 3 * kItemMargin)/2
fileprivate let kItemH = kItemW * 3 / 4
fileprivate let kHeaderH : CGFloat = 50

fileprivate let kNomalCellID = "kNomalCellID"
fileprivate let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {
    
    // MARK - 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        // 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 5
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 10, right: kItemMargin)
        
        let collectionView =  UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]// 适应父控件的长宽
        
        collectionView.register(UINib(nibName: "CollectionNomalCell",bundle: nil), forCellWithReuseIdentifier: kNomalCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//   设置UI界面
extension RecommendViewController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
}

//  遵循UICollectionView的数据源协议
extension RecommendViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNomalCellID, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 取出section 的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        
        return headerView
    }
}
