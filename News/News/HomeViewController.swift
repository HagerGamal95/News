//
//  ViewController.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let settings: Setting? = UserDefaults.get(withKey: kSetting)
        print(settings)
    }


}

