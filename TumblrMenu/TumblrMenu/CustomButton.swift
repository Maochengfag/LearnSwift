//
//  CustomButton.swift
//  TumblrMenu
//
//  Created by Mac on 2019/7/18.
//  Copyright © 2019年 Mac. All rights reserved.
//

import UIKit

enum ButtonImagePosition : Int{
    case PositionTop = 0
    case Positionleft
    case PositionBottom
    case PositionRight
}

extension UIButton{
    /**
     imageName:图片的名字
     title：button 的名字
     type ：image 的位置
     Space ：图片文字之间的间距
     */
    
    func setImageAndTitle(imageName:String,title:String,type:ButtonImagePosition,Space space:CGFloat) {
        self.setTitle(title, for: .normal)
        self.setImage(UIImage(named: imageName),for:.normal)
        self.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        let imageWidth : CGFloat = (self.imageView?.frame.size.width)!
        let imageHeight : CGFloat = (self.imageView?.frame.size.height)!
        
        var labelWidth : CGFloat = 0.0
        var labelHeight : CGFloat = 0.0
        
        labelWidth = CGFloat(self.titleLabel!.intrinsicContentSize.width)
        labelHeight = CGFloat(self.titleLabel!.intrinsicContentSize.height)
        
        var imageEdgeInsets : UIEdgeInsets = UIEdgeInsets()
        var labelEdgeInsets : UIEdgeInsets = UIEdgeInsets()
        
        switch type {
        case .PositionTop:
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight - space/2.0, 0, 0, -labelWidth)
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, -imageHeight-space/2.0, 0)
        case .Positionleft:
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0)
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, space/2.0)
        case .PositionBottom:
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth)
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -labelWidth, 0,0)
        case .PositionRight:
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0)
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth+space/2.0, 0, imageWidth/2.0)
            break
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
    
}
