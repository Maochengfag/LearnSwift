//
//  DetailViewController.swift
//  CustomTransitionV1
//
//  Created by Mac on 2019/7/20.
//  Copyright © 2019年 Mac. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UINavigationControllerDelegate {

    var bannerImageView: UIImageView!
    var img:UIImage!
    
    let RothkoDescription = "Mark Rothko (/ˈrɒθkoʊ/), born Markus Yakovlevich Rothkowitz (Russian: Ма́ркус Я́ковлевич Ротко́вич, Latvian: Markuss Rotkovičs; September 25, 1903 – February 25, 1970), was an American painter of Russian Jewish descent. Although Rothko himself refused to adhere to any art movement, he is generally identified as an abstract expressionist. With Jackson Pollock and Willem de Kooning, he is one of the most famous postwar American artists."
    
    fileprivate var percentDrivenTransition:UIPercentDrivenInteractiveTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bannerImageView = UIImageView(frame: CGRect(x: 10, y: 50, width: 400, height: 400))
        bannerImageView.center.x = self.view.center.x
        self.view.addSubview(bannerImageView)
        
        let textView = UITextView(frame: CGRect(x: 0, y: 500, width: self.view.frame.width, height: self.view.frame.height - 500))
        textView.text = RothkoDescription
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.backgroundColor = UIColor.white
        self.view.addSubview(textView)
        
        self.navigationController?.delegate = self
        
        // 手势监听
        let edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePanGestrueAction(_:)))
        edgePanGesture.edges = UIRectEdge.left
        self.view.addGestureRecognizer(edgePanGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationControllerOperation.pop {
            return CustomPopTransition()
        }
        else {
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animationController is CustomPopTransition {
            return self.percentDrivenTransition
        }
        else {
            return nil
        }
    }
    
    
    @objc func edgePanGestrueAction(_ edgePan:UIScreenEdgePanGestureRecognizer){
        let progress = edgePan.translation(in: self.view).x / self.view.bounds.width
        
        if edgePan.state == UIGestureRecognizerState.began {
            self.percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            self.navigationController?.popViewController(animated: true)
        } else if edgePan.state == UIGestureRecognizerState.changed {
            self.percentDrivenTransition?.update(progress)
        } else if edgePan.state == UIGestureRecognizerState.cancelled || edgePan.state == UIGestureRecognizerState.ended {
            if progress > 0.5 {
                self.percentDrivenTransition?.finish()
            } else {
                self.percentDrivenTransition?.cancel()
            }
            self.percentDrivenTransition = nil
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
