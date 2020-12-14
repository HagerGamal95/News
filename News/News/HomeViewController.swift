//
//  ViewController.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import UIKit

class HomeViewController: UIViewController {
    var settings: Setting?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settings = LocalStore.loadSettings()
    }

    @IBAction func filterClicked(_ sender: Any) {
        presentSettings()
    }
    private func presentSettings() {
        guard let settingsViewController = createViewControlller(controllerId: "SettingsViewController") as? SettingsViewController else { return }
        if let settings = self.settings {
            settingsViewController.settings = settings
        }
        settingsViewController.delegate = self
        self.present(settingsViewController, animated: true)
    }
}

extension HomeViewController: SettingsViewControllerDelegate {
    func selectionsConfirmed(settings: Setting) {
        self.dismiss(animated: true)
        self.settings = settings
        //to do search
    }
}
