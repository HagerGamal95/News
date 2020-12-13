//
//  SettingsViewController.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
    func selectionsConfirmed(settings: Setting)
}

class SettingsViewController: UIViewController {
    @IBOutlet weak var selectedCategoriesLabel: UILabel!
    @IBOutlet weak var selectCountryLabel: UILabel!
    @IBOutlet weak var selectLanguageLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var settings = Setting()
    weak var delegate : SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButton()
    }
    
    @IBAction func selectCountryClicked(_ sender: Any) {
        presentSingleSelectionsViewController(title: "Select a Country", values: Country.allCases.map { $0.rawValue }) { index in
            if let index = index {
                let country = Country.allCases[index]
                self.settings.country = country
                self.selectCountryLabel.text = country.rawValue
                self.updateSaveButton()
            }
        }
    }
    
    @IBAction func selectLanguageClicked(_ sender: Any) {
        presentSingleSelectionsViewController(title: "Select a Language", values: Language.allCases.map { $0.rawValue }) { index in
            if let index = index {
                let language = Language.allCases[index]
                self.settings.language = language
                self.selectLanguageLabel.text = language.rawValue
                self.updateSaveButton()
            }
        }
    }
    
    @IBAction func selectCategoriesClicked(_ sender: Any) {
        if let multiSelectionVC = self.createViewControlller(controllerId: "MultiSelectionViewController") as? MultiSelectionViewController {
            multiSelectionVC.selectionsTitle = "Select 3 Categories"
            multiSelectionVC.selectionsValues = Category.allCases.map { $0.rawValue }
            multiSelectionVC.indicesSelected = { indices in
                let categories = indices.map { Category.allCases[$0] }
                self.settings.categories = categories
                self.selectedCategoriesLabel.text = (categories.map{$0.rawValue}).joined(separator: ", ")
                self.updateSaveButton()
            }
            self.present(multiSelectionVC, animated: true)
        }
    }
    
    private func presentSingleSelectionsViewController(title: String, values: [String], indexSelected: ((Int?) -> Void)?) {
        if let singleSelectionVC = self.createViewControlller(controllerId: "SingleSelectionViewController") as? SingleSelectionViewController {
            singleSelectionVC.selectionsTitle = title
            singleSelectionVC.selectionsValues = values
            singleSelectionVC.indexSelected = indexSelected
            self.present(singleSelectionVC, animated: true)
        }
    }
    
    private func updateSaveButton() {
        saveButton.isEnabled = settings.country != nil && settings.language != nil && settings.categories != nil
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        self.delegate?.selectionsConfirmed(settings: self.settings)
    }
}
