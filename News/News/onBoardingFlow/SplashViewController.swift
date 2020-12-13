//
//  SpashViewController.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import UIKit

class SplashViewController: UIViewController {
    var decodeSetting: Setting? {
        get {
            return UserDefaults.get(withKey: kSetting)
        }
        set {
            UserDefaults.set(object: newValue, withkey: kSetting)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigate()

    }
    func navigate(){
        // Do any additional setup after loading the view.
        if (decodeSetting != nil) {
            //navigate to home
            self.present(storyBoardName: "Main", controllerId: "HomeViewController")

        }else{
           //navigate to settingVC
            self.present(storyBoardName: "Main", controllerId: "SettingsViewController")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
