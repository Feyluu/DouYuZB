//
//  MainViewController.swift
//  DouYuZB
//
//  Created by DuLu on 15/06/2017.
//  Copyright © 2017 DuLu. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC(storyboardName: "Home")
        addChildVC(storyboardName: "Live")
        addChildVC(storyboardName: "Follow")
        addChildVC(storyboardName: "Profile")
        
    }
    
    private func addChildVC(storyboardName: String) {
        // 1.通过storyboard获取控制器
        let childVC = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()!
        
        // 2.将childVC 作为子控制器
        addChildViewController(childVC)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
