//
//  UIView+Extension.swift
//  Selduk-exhibition
//
//  Created by 권준상 on 2022/05/02.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
