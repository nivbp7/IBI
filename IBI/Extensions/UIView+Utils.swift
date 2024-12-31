//
//  UIView+Utils.swift
//  IBI
//
//  Created by niv ben-porath on 31/12/2024.
//

import UIKit
extension UIView {
    func add(subviews views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
    }
}
