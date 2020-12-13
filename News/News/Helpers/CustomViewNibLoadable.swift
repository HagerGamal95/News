//
//  CustomViewNibLoadable.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import UIKit

protocol CustomViewNibLoadable: NibLoadable {
    
    var containerView: UIView! { get set }
    func loadView()
}

extension CustomViewNibLoadable where Self: UIView {
    func loadView() {
        Self.instantiate(WithFileOwner: self)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addFitSubview(containerView)
        self.backgroundColor = UIColor
            .clear
    }
}

typealias CustomView = CustomViewNibLoadable & UISetup


