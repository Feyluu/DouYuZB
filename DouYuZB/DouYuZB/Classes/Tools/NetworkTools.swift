//
//  NetworkTools.swift
//  AlamofireDemo
//
//  Created by DuLu on 19/06/2017.
//  Copyright © 2017 DuLu. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    class func requestData(type:MethodType, URLString:String,parameters:[String:String]?=nil,finishedCallback : @escaping (_ result:AnyObject) -> ()) {
        // 获取type类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: parameters, encoding:URLEncoding.default , headers: nil).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            
            // 回调结果
            finishedCallback(result as AnyObject)
        }
        
    }
}
