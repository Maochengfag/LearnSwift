//
//  ViewController.swift
//  FindMyPosition
//
//  Created by Mac on 2019/7/15.
//  Copyright © 2019年 Mac. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController ,CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager()
    let gecoder = CLGeocoder ()
    let locationLabel = UILabel()
    let locationStrLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let bgImageView = UIImageView(frame: self.view.bounds)
        bgImageView.image =  #imageLiteral(resourceName: "phoneBg")
        self.view.addSubview(bgImageView)
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style: .light)
        let blurView:UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.bounds;
        self.view.addSubview(blurView)
        
        locationManager.delegate = self;
        
        locationLabel.frame = CGRect(x:0, y:50,width:self.view.bounds.width, height:100)
        locationLabel.textAlignment = .center
        locationLabel.textColor = UIColor.white
        self.view.addSubview(locationLabel)
        
        locationStrLabel.frame = CGRect(x:0, y:100,width:self.view.bounds.width, height:100)
        locationStrLabel.textAlignment = .center
        locationStrLabel.textColor = UIColor.white
        self.view.addSubview(locationStrLabel)
        
        let findMyLocationBtn = UIButton(type: .custom)
        findMyLocationBtn.frame = CGRect(x:50,y:self.view.bounds.height-80, width:self.view.bounds.width-100,height:50)
        findMyLocationBtn.setTitle("Find My position", for: UIControlState.normal)
        findMyLocationBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        findMyLocationBtn.addTarget(self, action: #selector(findMyLocation), for: UIControlEvents.touchUpInside)
        self.view.addSubview(findMyLocationBtn)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func findMyLocation(){
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locations : NSArray = locations as NSArray
        let currentLocation = locations.lastObject as! CLLocation
        let locationStr = "lat:\(currentLocation.coordinate.latitude)lng:\(currentLocation.coordinate.longitude)"
        locationLabel.text = locationStr
        reverseGeocode(location: currentLocation)
        locationManager.stopUpdatingLocation()
    }
    
    func reverseGeocode(location:CLLocation){
        gecoder.reverseGeocodeLocation(location) { (placeMark, error) in
            if (error == nil){
                let tempArray = placeMark! as NSArray
                let mark = tempArray.firstObject as! CLPlacemark
                let addressDictionary = mark.addressDictionary! as NSDictionary
                let country  = addressDictionary.value(forKey: "Country") as! String
                let city = addressDictionary.value(forKey: "City") as! String
                let street = addressDictionary.value(forKey: "Street") as! String
                let finalAddress = "\(street),\(city),\(country)"
                self.locationLabel.text = finalAddress;
            }
        }
    }
}



















