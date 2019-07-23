//
//  fetchSubString.swift
//  ColorGradient
//
//  Created by Mac on 2019/7/16.
//  Copyright © 2019年 Mac. All rights reserved.
//

import UIKit
import Foundation

class fetchSubString: NSObject {

}

extension String {
    subscript (r:Range<Int>) ->String{
        get{
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return  String(self[startIndex..<endIndex])
        }
    }
}
