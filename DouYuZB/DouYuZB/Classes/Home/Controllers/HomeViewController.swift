//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by DuLu on 15/06/2017.
//  Copyright © 2017 DuLu. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    fileprivate lazy var pageTitlesView: PageTitlesView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kNavigationBarH+kStatusBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"];
        let titlesView = PageTitlesView(frame: titleFrame, titles: titles)
        titlesView.delegate = self
        return titlesView
    }()
    
    fileprivate lazy var pageContentView: PageContentView = { [weak self] in
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        // 2.确定所有的子视图
        var childViewControllers = [UIViewController]()
        childViewControllers.append(RecommendViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.groupTableViewBackground
            childViewControllers.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childViewControllers: childViewControllers, parentViewController: self)
        contentView.delegate = self
        
        return contentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        // 添加titlesView
        view.addSubview(pageTitlesView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

// mark - 设置UI界面
extension HomeViewController {
    
    fileprivate func setupUI() {
        
        // 0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 1.设置导航栏
        setupNavigationBar()
        
        // 2.添加titlesView
        view.addSubview(pageTitlesView)
        
        // 3.添加contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    
    private func setupNavigationBar() {
        
        // 设置左侧的logo
        let  btn = UIButton()
        btn.setImage(UIImage(named:"logo"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        // 设置右侧的
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highlightedImage: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highlightedImage: "btn_search_click", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highlightedImage: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
    
}

// mark - 遵守PageTitlesViewDelegate
extension HomeViewController : PageTitlesViewDelegate{
    func pageTitlesView(titlesView: PageTitlesView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

// mark - 遵守PageContentViewDelegate
extension HomeViewController : PageContentViewDelegate{
    func pageContentView(contentView: PageContentView, pregress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitlesView.setTitlesWith(progress: pregress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

