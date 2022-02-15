//
//  SettingsViewController.swift
//  A.S-InstaCloneFB
//
//  Created by Nazim Asadov on 28.01.22.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    @IBOutlet weak var logoutButtonOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutButtonOutlet.layer.cornerRadius = 15

    }

    @IBAction func logoutClicked(_ sender: Any) {
        do {
           try Auth.auth().signOut()
            performSegue(withIdentifier: "toMainVC", sender: nil)
        }catch{
            print("error")
        }
    }
}
