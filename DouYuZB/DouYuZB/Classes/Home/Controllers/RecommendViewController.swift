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
fileprivate let kNormalItemH = kItemW * 3 / 4
fileprivate let kBigItemH = kItemW * 4 / 3
fileprivate let kHeaderH : CGFloat = 50

fileprivate let kNormalCellID = "kNormalCellID"
fileprivate let kBigCellID = "kBigCellID"
fileprivate let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {
    
    // MARK - 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        // 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 5
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 10, right: kItemMargin)
        
        let collectionView =  UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]// 适应父控件的长宽
        
        collectionView.register(UINib(nibName: "CollectionNormalCell",bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionBigCell",bundle: nil), forCellWithReuseIdentifier: kBigCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    
    fileprivate lazy var recommendVM = RecommendViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
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

// 获取网络数据
extension RecommendViewController {
    fileprivate func loadData() {
        recommendVM.requestData { 
            self.collectionView.reloadData()
        }
    }
}

//  遵循UICollectionView的数据源协议
extension RecommendViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 取出模型
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        var cell = CollectionBaseCell()
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kBigCellID, for: indexPath) as! CollectionBigCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        }
        cell.anchor = anchor
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 取出section 的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        // 取出模型
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        
        
        return headerView
    }
}

// MARK:- 遵守UICollectionView的代理协议
extension RecommendViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kBigItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
