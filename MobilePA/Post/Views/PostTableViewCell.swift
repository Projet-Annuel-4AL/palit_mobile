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
    
    weak var delegate: PostTableViewCellDelegate?
    
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
        self.setUserImage(model: model)
        self.setUserName(model: model)
        self.setTitlePost(model: model)
        self.setPostText(model: model)
        self.setLikesCount(model: model)
        self.setRemarksCount(model: model)
        self.setLikesCount(model: model)
        self.setRemarksCount(model: model)
    }
    
    @IBAction func goToProfile(){
        delegate?.goToProfile()
    }
    
    @IBAction func goToRemarksOfPost(){
        delegate?.goToRemarksOfPost()
    }
    
    func setUserImage(model: Post){
        self.userImageView.layer.shouldRasterize = true
        self.userImageView.layer.cornerRadius = self.userImageView.frame.height/2
        self.userImageView.clipsToBounds = true
    }
    
    func setUserName(model: Post){
        var config = UIButton.Configuration.tinted()
        config.subtitle = "Posté par " + model.user.firstName
        
        self.buttonUserName.configuration = config
        self.buttonUserName.isUserInteractionEnabled = true
        
    }
    
    func setTitlePost(model: Post){
        self.titlePost.text = model.title
        self.titlePost.numberOfLines = 0
        self.titlePost.font = UIFont(name:"HelveticaNeue-Bold", size: 19.0)
    }
    
    func setPostText(model: Post){
        self.postText.numberOfLines = 0
        self.postText.text = model.text.content
    }
    
    func setLikesCount(model: Post){
        let likeCount = model.likes.count
        
        if(likeCount == 0){
            self.likesCount.text = ""
        } else {
            self.likesCount.text = String(likeCount)
        }
    }
    
    func setRemarksCount(model: Post){
        let remarksCount = model.remarks.count
        
        self.remarksCount.text = String(remarksCount)
    }
    
    
}

protocol PostTableViewCellDelegate: AnyObject {
    func goToProfile()
    func goToRemarksOfPost()
}
