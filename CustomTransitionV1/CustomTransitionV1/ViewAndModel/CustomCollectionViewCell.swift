//
//  CustomCollectionViewCell.swift
//  CustomTransitionV1
//
//  Created by Mac on 2019/7/20.
//  Copyright © 2019年 Mac. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    var imageView:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configCell(model:CustomCollectionViewCellModel){
        imageView = UIImageView(frame: self.bounds)
        imageView.image = model.image
        self.addSubview(imageView)
    }
}
