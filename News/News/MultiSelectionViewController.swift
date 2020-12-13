//
//  MultiSelectionViewController.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import UIKit

class MultiSelectionViewController: UIViewController {

    @IBOutlet weak var multiSelectionView: MultiSelectionsView!
    
    var selectionsTitle: String?
    var selectionsValues: [String]?
    
    var indicesSelected: ((Set<Int>) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        multiSelectionView.delegate = self
        if let title = self.selectionsTitle, let values = self.selectionsValues {
            multiSelectionView.configure(with: title, values: values, maxSelections: 3)
        }
    }
}

extension MultiSelectionViewController: SelectionsViewDelegate {
    func saveClicked() {
        indicesSelected?(multiSelectionView.selectedIndices)
        self.dismiss(animated: true)
    }
}
