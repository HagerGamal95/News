//
//  SelectionTableViewCell.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import UIKit

class SelectionTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkedImage: UIImageView!
    
    func configure(with title:String, checked: Bool) {
        titleLabel.text = title
        if checked {
            checkedImage.image = UIImage(named:"checked")
        } else {
            checkedImage.image = UIImage(named:"unChecked")
        }
    }
}
