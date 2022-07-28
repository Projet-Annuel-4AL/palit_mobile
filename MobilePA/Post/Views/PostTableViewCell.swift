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
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var datePost: UILabel!
    @IBOutlet weak var groupeLabel: UILabel!
    
    var likeService: LikeService = LikeWebService()
    var isliked: Bool!
    var delegate: PostTableViewCellDelegate?
    var model: Post!
    
    static let identifier = "PostTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "PostTableViewCell", bundle: nil)
    }
    
     override func awakeFromNib() {
        super.awakeFromNib()
         
     }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
        
    func configure(with model: Post, isLiked: Bool){
        self.model = model
        self.isliked = isLiked
        
        self.setUserImage()
        self.setUserName()
        self.setTitlePost()
        self.setLikesCount()
        self.setRemarksCount()
        self.setLikesCount()
        self.setLikeButton()
        self.setdatePost()
        
        if model.text.content.isEmpty {
            self.setPostCode()
        } else {
            self.setPostText()
        }
    }
    
    @IBAction func goToProfile(){
        delegate?.goToProfile(idUser: self.model.user.idUser)
    }
    
    @IBAction func handleLike(){
        if !self.isliked {
            self.likeButton.tintColor = UIColor.purple
            self.isliked = true
            self.likeService.createlike(idPost: model.idPost)
        } else {
            self.likeButton.tintColor = UIColor.black
            self.isliked = false
            let idLikeToDelete = self.getIdLike(likes: model.likes)
            self.likeService.deleteLike(idLike: idLikeToDelete)
        }
    }
    
    @IBAction func goToRemarksOfPost(){
        delegate?.goToRemarksOfPost(idPost: self.model.idPost)
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
        let htmlString = self.model.text.content.htmlAttributedString()
        
        self.postText.numberOfLines = 0
        self.postText.text = htmlString
    }
    
    func setPostCode(){
        let htmlString = self.model.code.content
        
        self.postText.numberOfLines = 0
        self.postText.text = htmlString
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
    
    func setLikeButton(){
        if self.isliked {
            self.likeButton.tintColor = UIColor.purple
        } else {
            self.likeButton.tintColor = UIColor.black
        }
    }
    
    func setdatePost(){
        let date = self.model.createdDate.prefix(10)
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let showDate = inputFormatter.date(from: String(date))
        inputFormatter.dateFormat = "dd/MM/yyyy"
        let resultString = inputFormatter.string(from: showDate!)
        
        
        self.datePost.text = resultString
    }
    
    func getIdLike(likes: [Like]) -> Int {
        let idCurentUser = UserDefaults.standard.string(forKey: "id")
        
        guard let idUser = idCurentUser else {
            return 0
        }
        
        for like in likes {
            if like.idUser == Int(idUser) {
                return like.idLike
            }
        }
        return 0
    }
    
    private func setImageUser(userImageString: String) -> UIImage{
        let url = URL(string: userImageString)
        let data = try? Data(contentsOf: url!)
        
        let userImage: UIImage
        
        if let imageData = data {
            userImage = UIImage(data: imageData)!
        } else {
            let userName = "not_found"
            guard let image = UIImage(named: userName) else {
                return UIImage(named: "interrogation")!
            }
            userImage = image
        }
        
        return userImage
    }
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy"

        if let date = inputFormatter.date(from: dateString) {

            let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = format

            return outputFormatter.string(from: date)
        }

        return nil
    }
    
}

protocol PostTableViewCellDelegate: AnyObject {
    func goToProfile(idUser: Int)
    func goToRemarksOfPost(idPost: Int)
}

extension String {
    func htmlAttributedString() -> String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }

        let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        )
        
        return attributedString?.string
    }
}
