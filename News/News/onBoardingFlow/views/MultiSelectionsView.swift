//
//  MultiSelectionsView.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import UIKit

class MultiSelectionsView: SelectionsView {
    var selectedIndices: Set<Int> = []
    var maxSelections : Int?
    
    func configure(with title: String, values: [String] , maxSelections: Int) {
        super.configure(with: title, values: values)
        self.maxSelections = maxSelections
        
        //        updateSaveButton()
    }
    
    override func isCellChecked(atIndexPath indexPath: IndexPath) -> Bool {
        selectedIndices.contains(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let maxSelections = maxSelections  else { return }
        
        if selectedIndices.contains(indexPath.row) {
            selectedIndices.remove(indexPath.row)
        } else if selectedIndices.count < maxSelections{
            selectedIndices.insert(indexPath.row)
        }
        
        tableView.reloadData()
        
        updateSaveButton()
    }
    
    private func updateSaveButton() {
        saveButton.isEnabled = selectedIndices.count == maxSelections
    }
}
