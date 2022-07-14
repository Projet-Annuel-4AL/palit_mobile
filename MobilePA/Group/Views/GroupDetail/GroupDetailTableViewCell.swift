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
    
    public func configure(with models: GroupPost){
        self.models = models
        
        self.setUserName()
        self.setPostText()
        self.setPostTitle()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUserName(){
        self.userName.text = "luffy"
    }
    
    private func setPostText(){
        self.postText.numberOfLines = 0
        self.postText.text = "un post"
    }
    
    private func setPostTitle(){
        self.postTitle.text = self.models.post.title
    }
    
}
