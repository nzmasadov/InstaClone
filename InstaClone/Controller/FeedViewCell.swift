//
//  FeedViewCell.swift
//  A.S-InstaCloneFB
//
//  Created by Nazim Asadov on 29.01.22.
//

import UIKit
import Firebase

class FeedViewCell: UITableViewCell {

    @IBOutlet weak var useremailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var likeNumberLabel: UILabel!
    @IBOutlet weak var  documentIdLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonPressed(_ sender: Any) {
        print("like pressed")
        let firestoreDatabase = Firestore.firestore()
        
        if let likeCount = Int(likeNumberLabel.text!) {
            let likeStore = ["likes": likeCount + 1] as [String: Any]
            firestoreDatabase.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)
        }
    }
}
