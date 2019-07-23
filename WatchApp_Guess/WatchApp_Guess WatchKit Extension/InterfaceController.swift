//
//  InterfaceController.swift
//  WatchApp_Guess WatchKit Extension
//
//  Created by Mac on 2019/7/18.
//  Copyright © 2019年 Mac. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController,WCSessionDelegate {

    @IBOutlet var resultSlider: WKInterfaceSlider!
    
    @IBOutlet var resultLabel: WKInterfaceLabel!
    
    @IBOutlet var resultConfirmButton: WKInterfaceButton!
    
    @IBOutlet var resultOfGuess: WKInterfaceLabel!
    
    
    var numberToBeGussed: Int!
    var numberOfSlider: Int!
    
    @IBAction func sliderUpdate(_ value: Float) {
        numberOfSlider = Int(value*5)
        resultLabel.setText("Your guess:\(numberOfSlider)")
    }
    
    @IBAction func guessAction() {
        if numberToBeGussed == nil {
            resultOfGuess.setText("Open iphone App first")
        }else if numberOfSlider == numberToBeGussed {
            resultOfGuess.setText("回答正确❤️")
        }else{
            resultOfGuess.setText("再猜一次💔")
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        
        if  WCSession.isSupported(){
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func session(_ session: WCSession, activationDidCompleteWith activationDidCompleteWitActivationState:WCSessionActivationState, error: Error?)  {
        
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
            numberToBeGussed = applicationContext["numberToBeGuessed"] as! Int
    }
}
