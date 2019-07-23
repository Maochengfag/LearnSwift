//
//  RightViewController.swift
//  snapChatLikeAppV1
//
//  Created by Mac on 2019/7/21.
//  Copyright © 2019年 Mac. All rights reserved.
//

import UIKit

class RightViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let rightImage:UIImage = #imageLiteral(resourceName: "rightSnap")
        let rightImageView = UIImageView(frame: self.view.frame)
        rightImageView.image = rightImage
        self.view.addSubview(rightImageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
