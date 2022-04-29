//
//  UIImageExtension.swift
//  UITableViewDemo
//
//  Created by ut-i02 on 28/04/2022.
//

import UIKit

extension UIImage {
    //Ref: https://nitishrajput912.medium.com/underline-tabbar-ios-swift-1ae53ac4a75f
    func createSelectionIndicator(color: UIColor, size: CGSize, lineHeight: CGFloat, bottomSafeArea: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        
        if bottomSafeArea > 0{
            UIRectFill(CGRect(x: 0, y: size.height - bottomSafeArea, width: size.width, height: lineHeight))
        }else{
            UIRectFill(CGRect(x: 0, y: size.height - lineHeight, width: size.width, height: lineHeight))
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
