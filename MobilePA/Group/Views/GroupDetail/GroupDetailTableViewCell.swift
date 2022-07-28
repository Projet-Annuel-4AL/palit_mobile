//
//  GroupDetailTableViewCell.swift
//  MobilePA
//
//  Created by Lucas Angoston on 10/07/2022.
//

import UIKit

class GroupDetailTableViewCell: UITableViewCell {
    
    static let identifier = "groupDetailTableViewCell"
        
    static func nib() -> UINib {
        return UINib(nibName: "GroupDetailTableViewCell", bundle: nil)
    }
    
    var models: GroupPost!
    
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var countRemarks: UILabel!
    @IBOutlet weak var countLikes: UILabel!
    
    public func configure(with models: GroupPost){
        self.models = models
        
        self.setUserName()
        self.setPostText()
        self.setPostTitle()
        self.setCountLikes()
        self.setCountRemarks()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUserName(){
        self.userName.text = models.post.user.firstName
    }
    
    private func setPostText(){
        self.postText.numberOfLines = 0
        self.postText.text = models.post.text.content
    }
    
    private func setPostTitle(){
        self.postTitle.text = self.models.post.title
    }
    
    private func setCountLikes(){
        self.countLikes.text = String(self.models.post.likes.count)
    }
    
    private func setCountRemarks(){
        self.countRemarks.text = String(self.models.post.remarks.count)
    }
    
}
