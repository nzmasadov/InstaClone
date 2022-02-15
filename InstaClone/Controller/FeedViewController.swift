//
//  FeedViewController.swift
//  A.S-InstaCloneFB
//
//  Created by Nazim Asadov on 28.01.22.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var commentArray = [String]()
    var useremailArray = [String]()
    var likesNumberArray = [Int]()
    var imageUrlArray = [String]()
    var idOfArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        getDataFromFirestore()
        
//        view.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9137254902, blue: 0.8235294118, alpha: 1)
//        tableView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9137254902, blue: 0.8235294118, alpha: 1)
 
    }
    
    
    func getDataFromFirestore() {
        let Firestoredatabase = Firestore.firestore()
        
        Firestoredatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "errOR")
            } else{
                
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.imageUrlArray.removeAll(keepingCapacity: false)
                    self.commentArray.removeAll(keepingCapacity: false)
                    self.likesNumberArray.removeAll(keepingCapacity: false)
                    self.useremailArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        self.idOfArray.append(documentID)
                    
                        if let commentUser = document.get("comment") as? String {
                            self.commentArray.append(commentUser)
                        }
                        if let likesNumber = document.get("likes") as? Int {
                            self.likesNumberArray.append(likesNumber)
                            print("\(likesNumber)RRRRR")
                        }
                        if let userEmail = document.get("emailBy") as? String {
                            self.useremailArray.append(userEmail)
                            
                        }
                        if let imageUrl = document.get("imageByUrl") as? String {
                            self.imageUrlArray.append(imageUrl)
                        }
                    }
                        self.tableView.reloadData()
            }
        }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return useremailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewCell", for: indexPath) as! FeedViewCell
        cell.commentLabel.text = commentArray[indexPath.row]
        cell.useremailLabel.text = useremailArray[indexPath.row]
        cell.likeNumberLabel.text = String(likesNumberArray[indexPath.row])
  //      cell.imageViewCell.sd_setImage(with: URL(string: self.imageUrlArray[indexPath.row]))
        cell.imageViewCell.sd_setImage(with: URL(string: self.imageUrlArray[indexPath.row]), placeholderImage: UIImage(named: "mixx"))
        cell.documentIdLabel.text = idOfArray[indexPath.row]
        return cell
    }
    

}
