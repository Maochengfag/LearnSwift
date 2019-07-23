//
//  ViewController.swift
//  ColorGradient
//
//  Created by Mac on 2019/7/16.
//  Copyright © 2019年 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CAAnimationDelegate {

    var gradientLayer: CAGradientLayer!
    var colorSets = [[CGColor]]()
    var currentColorSet: Int!
    
    let brightsetSkyColor_R = 21.0
    let brightsetSkyColor_G = 105.0
    let brightsetSkyColor_B = 203.0
    
    let darksetSkyColor_R = 8.0
    let darksetSkyColor_G = 33.0
    let darksetSkyColor_B = 63.0
    
    let highsetTemperature_R = 255.0
    let highsetTemperature_G = 200.0
    let highsetTemperature_B = 101.0
    
    let lowestTemperature_R = 47.0
    let lowestTemperature_G = 169.0
    let lowestTemperature_B = 199.0
    
    let lowestTemperature = 18
    let hightestTemperature = 41
    
    var totalIndex = 0
    var timelabel : UILabel!
    var temperatureLable : UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handelPanGesture(sender:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
        createColorSets()
    }
    
    override func viewWillAppear(_ animated:Bool){
        super.viewWillAppear(animated)
        self.createGradientLayer()
        timelabel = UILabel(frame: CGRect(x: 50, y: 40, width: 100, height: 100))
        timelabel.text = "1:00"
        timelabel.textColor = UIColor.white
        timelabel.font = UIFont.systemFont(ofSize: 28)
        self.view.addSubview(timelabel)
        
        temperatureLable = UILabel(frame: CGRect(x:250, y:40, width:100, height:100))
        temperatureLable.text = "18 ℃"
        temperatureLable.textColor = UIColor.white
        temperatureLable.font = UIFont.systemFont(ofSize:28)
        self.view.addSubview(temperatureLable)
    }
    
    func createGradientLayer()  {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = colorSets[currentColorSet]
        self.view.layer.addSublayer(gradientLayer)
    }
    
    func createColorSets(){
        for index in 1...12 {
            colorSets.append(ColorSet(index: Double(index)))
        }
        currentColorSet = 0
    }
    
    
    var lastY:CGFloat = 0.0, lastTotalIndex = 0, deltaOrigin = 0, indexForUp = 0
    
    @objc func handelPanGesture(sender:UIPanGestureRecognizer){
        let velocity = sender.velocity(in: self.view)
        let tranY = sender.translation(in: self.view).y
        if lastY == 0 || tranY*lastY < 0{
            lastY = tranY
            lastTotalIndex = totalIndex
        }
        
        let scopeY = self.view.frame.height / 24.0
        
        if velocity.y > 0 && lastTotalIndex < 23 {
            lastTotalIndex = Int((tranY - lastY) / scopeY)
            if totalIndex == 0 {
                deltaOrigin = lastTotalIndex
            }
            totalIndex += deltaOrigin
            lastTotalIndex = totalIndex
        }
        
        if velocity.y < 0  {
            indexForUp = Int((tranY - lastY) / scopeY)
            if indexForUp == 0 {
                deltaOrigin = lastTotalIndex
            }
            
            totalIndex = deltaOrigin + indexForUp
            lastTotalIndex = totalIndex
        }
        changeColor()
        changeLabels()
    }
    
    func changeColor() {
        guard lastTotalIndex > 0 && lastTotalIndex < 24 else {
            return
        }
        if lastTotalIndex < 12 {
            gradientLayer.colors = colorSets[lastTotalIndex]
        }else {
            gradientLayer.colors = colorSets[23 - lastTotalIndex]
        }
    }
    
    func changeLabels() {
        guard lastTotalIndex > 0 && lastTotalIndex < 25 else {
            return
        }
        if lastTotalIndex < 12 {
            temperatureLable.text = "\(lowestTemperature + lastTotalIndex) ℃"
        }else{
            temperatureLable.text = "\(hightestTemperature - lastTotalIndex) ℃"
        }
        timelabel.text = "\(lastTotalIndex):00"
    }
    
    func ColorSet(index: Double) -> Array<CGColor> {
        let sky_r = darksetSkyColor_R + (brightsetSkyColor_R - darksetSkyColor_R) * (index - 1) / 11.0
        let sky_g = darksetSkyColor_G + (brightsetSkyColor_G - darksetSkyColor_G)  * (index - 1) / 11.0
        let sky_b = darksetSkyColor_B + (brightsetSkyColor_B - darksetSkyColor_B) * (index - 1) / 11.0
        
        let  temr_r = lowestTemperature_R + (highsetTemperature_B - lowestTemperature_B) * (index - 1) / 11.0
        let tempr_g = lowestTemperature_G + (highsetTemperature_G - lowestTemperature_G) * (index - 1) / 11.0
        let tempr_b = lowestTemperature_B + (highsetTemperature_B - lowestTemperature_B) * (index - 1) / 11.0
        
        return [UIColor(red:CGFloat(sky_r/255.0), green:CGFloat(sky_g/255.0),blue:CGFloat(sky_b/255.0),alpha:1).cgColor,
                UIColor(red: CGFloat(temr_r/255.0), green: CGFloat(tempr_b/255.0), blue: CGFloat(tempr_g/255.0),alpha:1).cgColor]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

