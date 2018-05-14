//
//  UIColor+Extension.swift
//  AgricultureGeek
//
//  Created by 每天农资 on 2017/4/20.
//  Copyright © 2017年 每天农资. All rights reserved.
//

import UIKit


extension UIColor {
    
    /// 用十六进制颜色创建UIColor
    ///
    /// - Parameter hexColor: 十六进制颜色 (0F0F0F)
    convenience init(hexColor: String) {
        
        // 存储转换后的数值
        var red:UInt32 = 0, green:UInt32 = 0, blue:UInt32 = 0
        
        // 分别转换进行转换
        Scanner(string: hexColor[0..<2]).scanHexInt32(&red)
        
        Scanner(string: hexColor[2..<4]).scanHexInt32(&green)
        
        Scanner(string: hexColor[4..<6]).scanHexInt32(&blue)
        
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }
    
}

extension String {
    
    /// String使用下标截取字符串
    /// 例: "示例字符串"[0..<2] 结果是 "示例"
    subscript (r: Range<Int>) -> String {
        get {

            let str = self[self.index(self.startIndex, offsetBy: r.lowerBound)..<self.index(self.startIndex, offsetBy: r.upperBound)]
            return String(str)
        }
    }
    
    subscript (index: Int) -> String {
        get {
            return String(self[self.index(self.startIndex, offsetBy: index)])
        }
    }
}

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    
}



