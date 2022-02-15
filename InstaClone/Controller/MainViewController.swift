//
//  ViewController.swift
//  A.S-InstaCloneFB
//
//  Created by Nazim Asadov on 27.01.22.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
//        colorChanging()
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideKeyboardGesture)
        colorAdditions()
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
        // commentText.endEditing(true)
    }
    
    @IBAction func signinClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if error != nil {
                    self.showAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Something got wrong")
                }else {
                    self.performSegue(withIdentifier: "toSecondVC", sender: nil)
                }
            }
        }
    }
    
    @IBAction func signupClicked(_ sender: Any) {
    
        performSegue(withIdentifier: "toSignupVC", sender: nil)
    }
    

    func colorAdditions() {
        emailText.layer.cornerRadius = 15
        passwordText.layer.cornerRadius = 15
        
    }

  
}

