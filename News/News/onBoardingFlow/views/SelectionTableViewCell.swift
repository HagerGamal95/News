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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(with title:String, checked: Bool) {
        titleLabel.text = title
        if checked {
            checkedImage.image = UIImage(named:"checked") }
        else{
            checkedImage.image = UIImage(named:"unChecked")
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
