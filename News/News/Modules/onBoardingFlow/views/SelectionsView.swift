//
//  SelectionsView.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import UIKit

protocol SelectionsViewDelegate: class {
    func saveClicked()
}

class SelectionsView: UIView , CustomView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var values : [String]?
    weak var delegate: SelectionsViewDelegate?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 100
        }
    }
    
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
        tableView.reloadData()
    }
    
    func setupView() {
        tableView.register(UINib(nibName: "SelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectionTableViewCell")
        saveButton.isEnabled = false
    }
    
    func isCellChecked(atIndexPath indexPath: IndexPath) -> Bool {
        fatalError("Subclass must implement this function")
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        delegate?.saveClicked()
    }
}

extension SelectionsView : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.values?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectionTableViewCell", for: indexPath) as! SelectionTableViewCell
        if let values = values {
            cell.configure(with: values[indexPath.row], checked: isCellChecked(atIndexPath: indexPath))
        }
        return cell
    }
}

