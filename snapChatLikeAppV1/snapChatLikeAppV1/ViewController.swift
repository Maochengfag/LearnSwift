//
//  ViewController.swift
//  snapChatLikeAppV1
//
//  Created by Mac on 2019/7/21.
//  Copyright © 2019年 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let scrollView = UIScrollView(frame: self.view.bounds)
        self.view.addSubview(scrollView)
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentOffset = CGPoint(x: self.view.frame.width, y: 0)
        
        let leftVC = LeftViewController()
        let rightVC = RightViewController()
        let centerVC = CenterViewController()
        
        self.addChildViewController(leftVC)
        scrollView.addSubview(leftVC.view)
        leftVC.view.frame.origin.x = 0
        
        self.addChildViewController(centerVC)
        scrollView.addSubview(centerVC.view)
        centerVC.view.frame.origin.x = self.view.frame.width
        
        self.addChildViewController(rightVC)
        scrollView.addSubview(rightVC.view)
        rightVC.view.frame.origin.x = 2 * self.view.frame.width
        
        scrollView.contentSize = CGSize(width: 3 * self.view.frame.width, height: self.view.frame.height)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

