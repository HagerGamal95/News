//
//  SelectionsView.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import UIKit

class SelectionsView: UIView , CustomView, UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.values?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectionTableViewCell", for: indexPath) as! SelectionTableViewCell
        if let values = values {
            cell.configure(with: values[indexPath.row
            ], checked: false)
        }
     
        return cell
    }
    
    func setupView() {
        
    }
    
    @IBOutlet weak var containerView: UIView!
    
    var values : [String]?
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 100
            
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadView()
        setupView()
    }
    func configure(with title: String, values : [String]) {
        titleLabel.text = title
        self.values = values
    }

    

}
