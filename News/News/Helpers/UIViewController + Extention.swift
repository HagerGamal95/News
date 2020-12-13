//
//  UIViewController + Extention.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import Foundation
import UIKit

extension UIViewController{
    func createViewControlller(storyBoardName: String = "Main", controllerId: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyBoardName, bundle: nil)
        return storyboard.instantiateViewController(identifier: controllerId)
    }
    
    var window: UIWindow? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return nil }
        return window
    }
    
}
