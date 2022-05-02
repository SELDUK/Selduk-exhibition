//
//  UIFont+Extension.swift
//  Selduk-exhibition
//
//  Created by 권준상 on 2022/05/02.
//

import UIKit.UIFont

extension UIFont {
    
    static func nanumPen(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "NanumBarunpenOTF-Bold", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    
}
