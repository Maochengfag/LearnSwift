//
//  CustomCollectionViewCell.swift
//  Carousel Effect
//
//  Created by Mac on 2019/7/21.
//  Copyright © 2019年 Mac. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func configCell(model:CustomCollectionViewCellModel){
        let imageView = UIImageView(frame: self.bounds)
        imageView.image = model.image
        self.addSubview(imageView)
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
