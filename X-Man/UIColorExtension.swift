//
//  OverallExtension.swift
//  X-Man
//
//  Created by wuqiuhao on 2016/7/7.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

extension UIColor {
    //  颜色转换为背景图片
    func imageWithColor()-> UIImage {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetRGBFillColor(context, r, g, b, a)
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}