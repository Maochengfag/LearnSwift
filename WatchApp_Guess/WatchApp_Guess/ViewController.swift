//
//  ViewController.swift
//  WatchApp_Guess
//
//  Created by Mac on 2019/7/18.
//  Copyright © 2019年 Mac. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController,WCSessionDelegate{

    var wcsession: WCSession!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let generateNumberBtn = UIButton(type: .custom)
        generateNumberBtn.frame = CGRect(x: 10, y: 10, width: 200, height: 50)
        generateNumberBtn.setTitle("Generate", for: .normal)
        generateNumberBtn.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(generateNumberBtn)
        generateNumberBtn.center = self.view.center
        generateNumberBtn.addTarget(self, action: #selector(generateNumber), for: .touchUpInside)
        generateNumberBtn.setTitleColor(UIColor.red, for: .highlighted)
        generateNumberBtn.setTitleColor(UIColor.green, for: .selected)
        generateNumberBtn.layer.borderColor = UIColor.black.cgColor
        generateNumberBtn.layer.borderWidth = 1
        generateNumberBtn.layer.cornerRadius = 8
        
        wcsession  = WCSession.default
        if  WCSession.isSupported(){
            wcsession.delegate = self
            wcsession.activate()
        }
        
        self.view.backgroundColor = UIColor.yellow
    }

    @objc func generateNumber(){
        let number:Int = Int(arc4random()) % 5 + 1
        do {
            try wcsession.updateApplicationContext(["numberToBeGuessed" : number])
        }catch {
            print("Error happened")
        }
    }
    
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print(activationState)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

