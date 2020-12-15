//
//  UIView+extension.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import UIKit

extension UIView {
    
    @discardableResult
    func addFitSubview(_ view: UIView,
                       leading: CGFloat = 0,
                       leadingPriority: UILayoutPriority = .required,
                       trailing: CGFloat = 0,
                       trailingPriority: UILayoutPriority = .required,
                       top: CGFloat = 0,
                       topPriority: UILayoutPriority = .required,
                       bottom: CGFloat = 0,
                       bottomPriority: UILayoutPriority = .required) -> (leading: NSLayoutConstraint, trailing: NSLayoutConstraint, top: NSLayoutConstraint, bottom: NSLayoutConstraint) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        let leadingConstraint = view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leading)
        leadingConstraint.priority = leadingPriority
        leadingConstraint.isActive = true
        
        let topConstraint = view.topAnchor.constraint(equalTo: topAnchor, constant: top)
        topConstraint.priority = topPriority
        topConstraint.isActive = true
        
        let trailingConstraint = self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing)
        trailingConstraint.priority = trailingPriority
        trailingConstraint.isActive = true
        
        let bottomConstraint = self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
        bottomConstraint.priority = bottomPriority
        bottomConstraint.isActive = true
        
        return (leading: leadingConstraint, trailing: trailingConstraint, top: topConstraint, bottom: bottomConstraint)
    }
}
