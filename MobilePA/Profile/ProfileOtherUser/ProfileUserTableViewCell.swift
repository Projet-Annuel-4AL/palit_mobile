//
//  ProfileUserTableViewCell.swift
//  MobilePA
//
//  Created by Lucas Angoston on 12/07/2022.
//

import UIKit

class ProfileUserTableViewCell: UITableViewCell {

    static let identifier = "profileUserTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ProfileUserTableViewCell", bundle: nil)
    }
    
    var models: Post!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postContent: UILabel!
    @IBOutlet weak var countLikes: UILabel!
    @IBOutlet weak var countRemarks: UILabel!
    
    func configure(with models: Post){
        self.models = models
        
        self.setUserName()
        self.setPostTitle()
        self.setPostContent()
        self.setCountLikes()
        self.setCountRemarks()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUserName(){
        self.userName.text = self.models.user.firstName
    }
    
    private func setPostTitle(){
        self.postTitle.text = self.models.title
    }
    
    private func setPostContent(){
        self.postContent.text = models.text.content
    }
    
    private func setCountLikes(){
        self.countLikes.text = String(models.likes.count)
    }
    
    private func setCountRemarks(){
        self.countRemarks.text = String(models.remarks.count)
    }
    
}
