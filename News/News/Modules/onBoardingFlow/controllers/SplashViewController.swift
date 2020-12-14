//
//  SpashViewController.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import UIKit

class SplashViewController: UIViewController {
    var settings: Setting? {
        get { LocalStore.loadSettings() }
        set { LocalStore.save(settings: newValue) }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigate()
    }
    
    private func navigate() {
        if settings == nil {
            navigateToSettings()
        } else {
            navigateToHome()
        }
    }
    
    private func navigateToSettings() {
        guard let settingsViewController = createViewControlller(controllerId: "SettingsViewController") as? SettingsViewController else { return }
        settingsViewController.delegate = self
        settingsViewController.modalPresentationStyle = .fullScreen
        self.present(settingsViewController, animated: true)
    }
    
    private func navigateToHome() {
        let viewController = createViewControlller(controllerId: "HomeViewController")
        window?.rootViewController = viewController
    }
}

extension SplashViewController : SettingsViewControllerDelegate{
    func selectionsConfirmed(settings: Setting) {
        self.settings = settings
        self.navigate()
    }
}
