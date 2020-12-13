//
//  UIViewController + Extention.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import Foundation
import UIKit
extension UIViewController{
    func present(storyBoardName : String , controllerId : String){
        let storyboard = UIStoryboard(name: storyBoardName, bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: controllerId)
        present(controller, animated: true)
    }
}
