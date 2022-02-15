//
//  RegisterViewController.swift
//  A.S-InstaCloneFB
//
//  Created by Nazim Asadov on 10.02.22.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
  
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideKeyboardGesture)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
        // commentText.endEditing(true)
    }
    
    
    @IBAction func registerPressed(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authdata, error in
                if error != nil {
                    self.showAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else {
                    let alert = UIAlertController(title: "Congratulation", message: "Signup is succesfull", preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in
                        self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    }
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            self.showAlert(titleInput: "Error", messageInput: "Username or Password is not allowed")
        }
    }
    
}
