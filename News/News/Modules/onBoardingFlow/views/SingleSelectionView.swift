//
//  SingleSelectionView.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import UIKit

class SingleSelectionView: SelectionsView {
    var selectedIndex: Int?
    
    override func isCellChecked(atIndexPath indexPath: IndexPath) -> Bool {
        indexPath.row == selectedIndex
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let oldIndex = selectedIndex
        selectedIndex = indexPath.row
        
        var indexPaths = [indexPath]
        if let oldIndex = oldIndex {
            indexPaths.append(IndexPath(row: oldIndex, section: 0))
        }
        
        tableView.reloadRows(at: indexPaths, with: .automatic)
        
        updateSaveButton()
    }
    
    private func updateSaveButton() {
        saveButton.isEnabled = selectedIndex != nil
    }
}
