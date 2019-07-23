//
//  CustomTransition.swift
//  Vertical Menu Transition
//
//  Created by Mac on 2019/7/19.
//  Copyright © 2019年 Mac. All rights reserved.
//

import UIKit

@objc protocol CustomTransitionDelagate{
    func dismiss()
}

class CustomTransition: NSObject,UIViewControllerAnimatedTransitioning{

    public var delegate: CustomTransitionDelagate!
    public var navigationType: ViewControllerNavigationType!
    private var snapShot: UIView!
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView
        
        let fromView = fromViewController?.view
        let toView = toViewController?.view
        
        if navigationType == .Present {
            fromView?.transform = CGAffineTransform(translationX: 0, y: 0)
            toView?.transform = CGAffineTransform(translationX: 0, y: -50)
            snapShot = (fromView?.snapshotView(afterScreenUpdates: true))!
            containerView.addSubview(toView!)
            containerView.addSubview(snapShot)
            
            let tapGesture = UITapGestureRecognizer(target: delegate, action: #selector(CustomTransitionDelagate.dismiss))
            snapShot.addGestureRecognizer(tapGesture)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.snapShot.transform = CGAffineTransform(translationX: 0, y: containerView.frame.height - 150)
            }, completion: { (_) in
                transitionContext.completeTransition(true)
                fromViewController?.endAppearanceTransition()
                toViewController?.endAppearanceTransition()
            })
        }else{
            UIView.animate(withDuration: 0.5, animations: {
                self.snapShot.transform = CGAffineTransform.identity
                fromView?.transform = CGAffineTransform.identity
            }) { (_) in
                transitionContext.completeTransition(true)
                fromViewController?.endAppearanceTransition()
                toViewController?.endAppearanceTransition()
            }
        }
    }
}
