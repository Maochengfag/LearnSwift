//
//  ViewController.swift
//  Vertical Menu Transition
//
//  Created by Mac on 2019/7/19.
//  Copyright © 2019年 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CustomTransitionDelagate,UIViewControllerTransitioningDelegate {
    
    var transition = CustomTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let imgView = UIImageView(frame: self.view.frame)
        imgView.image = #imageLiteral(resourceName: "Photo")

        self.view.addSubview(imgView)
        
        let menuButtonBar = UIBarButtonItem(title: "🎾", style: .plain, target: self, action: #selector(triggerMenu))
        self.navigationItem.leftBarButtonItem = menuButtonBar
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func triggerMenu(){
        let menuViewController = MenuViewController()
        menuViewController.transitioningDelegate = self;
        menuViewController.modalPresentationStyle = .custom
        self.navigationController?.present(menuViewController, animated: true, completion: nil)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.navigationType = .Dismiss
        return transition
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.delegate = self
        transition.navigationType = .Present
        return transition
    }
    
    func dismiss() {
        dismiss(animated: true)
    }
}

public enum ViewControllerNavigationType:Int {
    case Present = 0
    case Dismiss = 1
}
