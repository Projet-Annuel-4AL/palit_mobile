//
//  PostTableViewCell.swift
//  MobilePA
//
//  Created by Lucas Angoston on 09/07/2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var buttonUserName: UIButton!
    @IBOutlet weak var titlePost: UILabel!
    @IBOutlet var postText: UILabel!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var remarksCount: UILabel!
    
    var delegate: PostTableViewCellDelegate?
    var model: Post!
    
    static let identifier = "PostTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "PostTableViewCell", bundle: nil)
    }
    
     override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
    func configure(with model: Post){
        self.model = model
        
        self.setUserImage()
        self.setUserName()
        self.setTitlePost()
        self.setPostText()
        self.setLikesCount()
        self.setRemarksCount()
        self.setLikesCount()
    }
    
    @IBAction func goToProfile(){
        delegate?.goToProfile(idUser: self.model.user.idUser)
    }
    
    @IBAction func goToRemarksOfPost(){
        delegate?.goToRemarksOfPost()
    }
    
    func setUserImage(){
        self.userImageView.layer.shouldRasterize = true
        self.userImageView.layer.cornerRadius = self.userImageView.frame.height/2
        self.userImageView.clipsToBounds = true
    }
    
    func setUserName(){
        var config = UIButton.Configuration.tinted()
        config.subtitle = "Posté par " + self.model.user.firstName
        
        self.buttonUserName.configuration = config
        self.buttonUserName.isUserInteractionEnabled = true
        
    }
    
    func setTitlePost(){
        self.titlePost.text = self.model.title
        self.titlePost.numberOfLines = 0
        self.titlePost.font = UIFont(name:"HelveticaNeue-Bold", size: 19.0)
    }
    
    func setPostText(){
        self.postText.numberOfLines = 0
        self.postText.text = self.model.text.content
    }
    
    func setLikesCount(){
        let likeCount = self.model.likes.count
        
        if(likeCount == 0){
            self.likesCount.text = ""
        } else {
            self.likesCount.text = String(likeCount)
        }
    }
    
    func setRemarksCount(){
        let remarksCount = self.model.remarks.count
        
        self.remarksCount.text = String(remarksCount)
    }
    
    
}

protocol PostTableViewCellDelegate: AnyObject {
    func goToProfile(idUser: Int)
    func goToRemarksOfPost()
}
