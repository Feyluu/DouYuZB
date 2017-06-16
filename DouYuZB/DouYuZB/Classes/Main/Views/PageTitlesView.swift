//
//  PageTitlesView.swift
//  DouYuZB
//
//  Created by DuLu on 16/06/2017.
//  Copyright © 2017 DuLu. All rights reserved.
//

import UIKit

fileprivate let kScrollViewLineH : CGFloat = 2

class PageTitlesView: UIView {
    
    // 定义属性
    fileprivate var titles:[String]
    
    // 懒加载属性
    fileprivate lazy var titlesLables:[UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView:UIScrollView = {
        let scrollow = UIScrollView()
        scrollow.showsHorizontalScrollIndicator = false
        scrollow.scrollsToTop = false
        scrollow.bounces = false
        return scrollow
    }()
    
    // 懒加载添加scrollLine
    fileprivate lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    

    // 自定义构造函数
    init(frame: CGRect, titles:[String]) {
        self.titles = titles
        
        super.init(frame:frame)
        
        // 设置界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitlesView {
    fileprivate func setupUI() {
        // 1.添加到Scrollow
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2.添加titles对应的label
        setupTitleLabels()
        
        // 3.设置底线和滑动的线
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitleLabels() {
        
        let labelW:CGFloat = frame.width/CGFloat(titles.count)
        let labelH:CGFloat = frame.height-kScrollViewLineH
        let labelY:CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            let labelX:CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titlesLables.append(label)
        }
    }
    
    private func setupBottomLineAndScrollLine() {
        // 1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height-lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 2.添加scollLine
        // 2.1 获取第一个label
        guard let firstLabel = titlesLables.first else {
            return
        }
        firstLabel.textColor = UIColor.orange
        // 2.2 设置scrollLine属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kScrollViewLineH, width: firstLabel.frame.width, height: kScrollViewLineH)
    }
}
