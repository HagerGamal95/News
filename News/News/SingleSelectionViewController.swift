//
//  SingleSelectionViewController.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import UIKit

class SingleSelectionViewController: UIViewController {
    @IBOutlet weak var singleSelectionView: SingleSelectionView!
    
    var selectionsTitle: String?
    var selectionsValues: [String]?
    
    var indexSelected: ((Int?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        singleSelectionView.delegate = self
        if let title = self.selectionsTitle, let values = self.selectionsValues {
            singleSelectionView.configure(with: title, values: values)
        }
    }
}

extension SingleSelectionViewController : SelectionsViewDelegate {
    func saveClicked() {
        indexSelected?(singleSelectionView.selectedIndex)
        self.dismiss(animated: true)
    }
}
