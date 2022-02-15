//
//  UploadViewController.swift
//  A.S-InstaCloneFB
//
//  Created by Nazim Asadov on 28.01.22.
//

import UIKit
import Firebase
import FirebaseFirestore

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var uploadButtonOutlet: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commentText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadButtonOutlet.layer.cornerRadius = 15
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideKeyboardGesture)
        uploadButtonOutlet.isEnabled = false

    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
        // commentText.endEditing(true)
    }
    

    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        uploadButtonOutlet.isEnabled = true
    }
    
    func makeAlert (title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
        
    
    @IBAction func uploadPressed(_ sender: Any) {
        
        let storage = Storage.storage()
        let reference = storage.reference()
        
       let mediaFolder = reference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")

            imageReference.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Something got wrong")
//                    print(error?.localizedDescription ?? "Something gets wrong")
                }else {
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                           
                            // DATABASE
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            var referenceDatabase: DocumentReference? = nil
                            
                            let referenceData = ["emailBy": Auth.auth().currentUser?.email, "comment": self.commentText.text, "imageByUrl": imageUrl, "date": FieldValue.serverTimestamp(), "likes": 0] as [String: Any]
                            referenceDatabase = firestoreDatabase.collection("Posts").addDocument(data: referenceData, completion: { error in
                                if error != nil {
                                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                                }else{
                                    self.commentText.text = ""
                                    self.imageView.image = UIImage(named: "rectangle")
                                    self.tabBarController?.selectedIndex = 0
                                    self.uploadButtonOutlet.isEnabled = false
                                }
                            })
                        }
                    }
                    
                }
            }
            
        }
        
    }
    
    
}
