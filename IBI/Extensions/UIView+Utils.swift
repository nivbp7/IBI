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
    
    func snap(to view: UIView, shouldAddToView: Bool = true) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if shouldAddToView {
            view.addSubview(self)
        }
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
