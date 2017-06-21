//
//  RecommendViewModel.swift
//  DouYuZB
//
//  Created by DuLu on 20/06/2017.
//  Copyright © 2017 DuLu. All rights reserved.
//

import UIKit

class RecommendViewModel {
    // MARK - 懒加载属性
    public lazy var anchorGroups:[AnchorGroupModel] = [AnchorGroupModel]()
    fileprivate lazy var bigDataGroup : AnchorGroupModel = AnchorGroupModel()
    fileprivate lazy var prettyGroup : AnchorGroupModel = AnchorGroupModel()
}

// 发送网络请求
extension RecommendViewModel {
    func requestData(finishedCallBack : @escaping () -> ()) {
        // 0. 定义参数
        let parameters = ["limt":"4","offset":"0","time":NSDate.getCurrentTime()]
        
        // 1.创建dispatch组
        let dispatchGroup = DispatchGroup()
        
        // 2.请求推荐数据
        dispatchGroup.enter()
         NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters:["time":NSDate.getCurrentTime()] ) { (result) in
            // 1.将result转成字典类型
            guard let resultDic = result as? [String:NSObject] else {return}
            // 2.根据key值data,获取数组
            guard let dataArray = resultDic["data"] as? [[String:NSObject]] else {return}
            // 3.遍历字典，并且转成模型对象
            // 3.1 设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray {
                let anchor = AnchorModel.init(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            dispatchGroup.leave()
        }
        
        // 3.请求颜值数据
        dispatchGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters:parameters ) { (result) in
            // 1.将result转成字典类型
            guard let resultDic = result as? [String:NSObject] else {return}
            // 2.根据key值data,获取数组
            guard let dataArray = resultDic["data"] as? [[String:NSObject]] else {return}
            // 3.遍历字典，并且转成模型对象

            // 3.1 设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            for dict in dataArray {
                let anchor = AnchorModel.init(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dispatchGroup.leave()
        }
        
        // 4.请求2-12部分数据 http://capi.douyucdn.cn/api/v1/getHotCate
        dispatchGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters:parameters ) { (result) in
            // 1.将result转成字典类型
            guard let resultDic = result as? [String:NSObject] else {return}
            // 2.根据key值data,获取数组
            guard let dataArray = resultDic["data"] as? [[String:NSObject]] else {return}
            // 3.遍历数组，获取字典，并将字典转成模型字典
            for dict in dataArray {
                let group = AnchorGroupModel(dict: dict)
                self.anchorGroups.append(group)
            }
            for group in self.anchorGroups {
                for anchor in group.anchors {
                    
                }
            }
            dispatchGroup.leave()
        }
        
        // 5. 判断是否全部数据请求完毕
        dispatchGroup.notify(queue: DispatchQueue.main) {
            //在这里告诉调用者,下完完毕,执行下一步操作
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishedCallBack()
        }
    }
}
