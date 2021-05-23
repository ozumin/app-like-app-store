//
//  UIView+Extensions.swift
//  AppStoreLike
//
//  Created by Mizuo Nagayama on 2021/05/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView..., constraints: NSLayoutConstraint...) {
        views.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        constraints.forEach { $0.isActive = true }
    }
}
