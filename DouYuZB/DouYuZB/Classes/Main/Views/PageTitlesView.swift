//
//  PageTitlesView.swift
//  DouYuZB
//
//  Created by DuLu on 16/06/2017.
//  Copyright © 2017 DuLu. All rights reserved.
//

import UIKit

protocol PageTitlesViewDelegate : class {
    func pageTitlesView(titlesView:PageTitlesView, selectedIndex index:Int)
}


fileprivate let kScrollViewLineH : CGFloat = 2
fileprivate let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
fileprivate let kSelectedColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)


class PageTitlesView: UIView {
    
    // 定义属性
    fileprivate var currentIndex : Int = 0
    fileprivate var titles:[String]
    weak var delegate:PageTitlesViewDelegate?// 代理最好用weak
    
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
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            let labelX:CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titlesLables.append(label)
            
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(self.titleLabelClick(sender:)))
            label.addGestureRecognizer(tapGes)
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
        firstLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        // 2.2 设置scrollLine属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kScrollViewLineH, width: firstLabel.frame.width, height: kScrollViewLineH)
    }
}

// 监听label的点击事件
extension PageTitlesView {
    
    @objc fileprivate func titleLabelClick(sender: UITapGestureRecognizer) {
        
        guard let currentLabel = sender.view as? UILabel else {
            print("currentLabel is nil")
            return
        }
        
        // 2. 获取前一个label
        let oldLabel = titlesLables[currentIndex]
        
        // 3.切换文字的颜色
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        currentLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        
        
        // 4.保存当前label的索引
        currentIndex = currentLabel.tag
        
        // 5.滑动条的位置改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.2) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        // 6.通知代理
        delegate?.pageTitlesView(titlesView: self, selectedIndex: currentIndex)

    }
}

// 对外暴露的方法
extension PageTitlesView {
    func setTitlesWith(progress:CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        //print("progress:\(progress), sourceInde:\(sourceIndex), targetIndex:\(targetIndex)")
        
        // 1. 取出souceLabel/target
        let sourceLabel = titlesLables[sourceIndex]
        let targetLabel = titlesLables[targetIndex]
        
        // 2. 处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 3.颜色的渐变（复杂）
        // 3.1 取出变化的范围
        let colorDelta = (kSelectedColor.0-kNormalColor.0,kSelectedColor.1-kNormalColor.1,kSelectedColor.2-kNormalColor.2)
        
        // 3.2 变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectedColor.0-colorDelta.0 * progress, g: kSelectedColor.1-colorDelta.1 * progress, b: kSelectedColor.2-colorDelta.2 * progress)
        
        // 3.3 变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 4.记录最新的index
        currentIndex = targetIndex
    }
}
