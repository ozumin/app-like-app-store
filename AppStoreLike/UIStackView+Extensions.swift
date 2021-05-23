//
//  UIStackView+Extensions.swift
//  AppStoreLike
//
//  Created by Mizuo Nagayama on 2021/05/23.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView..., constraints: NSLayoutConstraint...) {
        views.forEach {
            addArrangedSubview($0)
        }
        constraints.forEach { $0.isActive = true }
    }
}
