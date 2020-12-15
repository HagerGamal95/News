//
//  TableViewExtention.swift
//  News
//
//  Created by hager gamal on 12/14/20.
//

import Foundation
import UIKit

extension UITableView {
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}
