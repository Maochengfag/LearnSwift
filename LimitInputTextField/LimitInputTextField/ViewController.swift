//
//  ViewController.swift
//  LimitInputTextField
//
//  Created by Mac on 2019/7/15.
//  Copyright © 2019年 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    var limitedTextView:UITextView!
    var allowInputNumberLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        self.initNavigationBar()
        self.initInputField()
     
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(note:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initInputField(){
       
        let navibarFrame = self.navigationController?.navigationBar.frame
        let statusBarFrame = UIApplication.shared.statusBarFrame
        let avatarImgView = UIImageView(frame: CGRect(x: 0, y: (navibarFrame?.height)! + statusBarFrame.height + 10, width: 70, height: 70))
        let image = UIImage(named: "avatar");
        
        avatarImgView.image =  #imageLiteral(resourceName: "avatar.jpg")
        self.view.addSubview(avatarImgView)
        
        limitedTextView = UITextView(frame: CGRect(x:80,y:avatarImgView.frame.height, width:self.view.frame.width - 70-20,height:300))
        self.view.addSubview(limitedTextView)
        
        limitedTextView.delegate = self
        limitedTextView.font = UIFont.systemFont(ofSize: 20)
        
        allowInputNumberLabel = UILabel(frame: CGRect(x:self.view.frame.width-50,y:self.view.frame.height-40,width:50,height:40))
        self.view.addSubview(allowInputNumberLabel)
        allowInputNumberLabel.text = "140"
        allowInputNumberLabel.textAlignment = .right
    }
    
    func initNavigationBar(){
        let leftItem = UIBarButtonItem(title: "close", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = leftItem
        let rightItem = UIBarButtonItem(title: "Tweet", style: .plain, target: self, action: nil)
        rightItem.tintColor = UIColor.green
        navigationItem.rightBarButtonItem = rightItem
    }
    
    func textViewDidChange(_ textView:UITextView){
        let currentCharactorCount = NSString(string: textView.text).length
        
        if currentCharactorCount >= 140{
            limitedTextView.resignFirstResponder()
        }
        allowInputNumberLabel.text = "\(140-currentCharactorCount)"
    }
    
    @objc func keyboardWillChangeFrame(note: Notification){
        let duration = note.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let endFrame = (note.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let y = endFrame.origin.y
        
        let margin = UIScreen.main.bounds.height - y
        UIView.animate(withDuration: duration) {
            if  margin > 0 {
                self.allowInputNumberLabel.frame.origin.y = self.allowInputNumberLabel.frame.origin.y - margin
            }
            else{
                self.allowInputNumberLabel.frame.origin.y = self.view.frame.height - 40
            }
        }
    }
}


