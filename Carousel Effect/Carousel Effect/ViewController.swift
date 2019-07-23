//
//  ViewController.swift
//  Carousel Effect
//
//  Created by Mac on 2019/7/21.
//  Copyright © 2019年 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var collectionView : UICollectionView!
    var dataSource : Array<CustomCollectionViewCellModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let bgView = UIView(frame: self.view.bounds)
        let bgImageView = UIImageView(frame: self.view.bounds)
        bgImageView.image = #imageLiteral(resourceName: "bg")
        bgView.addSubview(bgImageView)
        
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .light)
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.bounds
        bgView.addSubview(blurView)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.backgroundView = bgView
        collectionView.delegate = self
        
        collectionView  .register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        self.view.addSubview(collectionView)
        
        let model1 = CustomCollectionViewCellModel()
        model1.image = #imageLiteral(resourceName: "Photo5")
        
        let model2 = CustomCollectionViewCellModel()
        model2.image = #imageLiteral(resourceName: "Photo2")
        
        let model3 = CustomCollectionViewCellModel()
        model3.image = #imageLiteral(resourceName: "Photo3")
        
        let model4 = CustomCollectionViewCellModel()
        model4.image = #imageLiteral(resourceName: "Photo1")
        
        let model5 = CustomCollectionViewCellModel()
        model5.image = #imageLiteral(resourceName: "Photo4")
        
        dataSource = Array(arrayLiteral: model1,model2,model3,model4,model5)
        
        let segmentView = UISegmentedControl(items: ["FlowLayout","CustomLayout"])
        
        let titleTextAttributes = [kCTForegroundColorAttributeName:UIColor.white as AnyObject]
        segmentView.setTitleTextAttributes(titleTextAttributes, for: UIControlState.normal)
        segmentView.setTitleTextAttributes([kCTForegroundColorAttributeName : UIColor.black as AnyObject], for: UIControlState.selected)
        
        segmentView.tintColor = UIColor.white
        segmentView.isMomentary = false
        segmentView.frame = CGRect(x: 10, y:50, width: (self.view.frame.width)-20, height: segmentView.bounds.height)
        segmentView.selectedSegmentIndex = 0
        segmentView.addTarget(self, action: #selector(action_segmentValueChanged(sender:)), for: UIControlEvents.valueChanged)
        self.view.addSubview(segmentView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func action_segmentValueChanged(sender:UISegmentedControl){
        let layout = sender.selectedSegmentIndex == 0 ? UICollectionViewFlowLayout() : CustomCollectionViewLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 220, height: 360)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        cell.configCell(model: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 20, 10, 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

