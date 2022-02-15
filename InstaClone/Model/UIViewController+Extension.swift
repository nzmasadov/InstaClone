//
//  UIViewController+Extension.swift
//  A.S-InstaCloneFB
//
//  Created by Nazim Asadov on 04.02.22.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
