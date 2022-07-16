//
//  RemarkTableViewCell.swift
//  MobilePA
//
//  Created by Lucas Angoston on 16/07/2022.
//

import UIKit

class RemarkTableViewCell: UITableViewCell {
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var remarkDate: UILabel!
    @IBOutlet weak var remarkContent: UILabel!
    
    static let identifier = "remarkTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "RemarkTableViewCell", bundle: nil)
    }
    
    var model: RemarkPost!
    var remarkUsername: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with model: RemarkPost){
        self.model = model
        
        self.setUsername()
        self.setUserPicture()
        self.setRemarkDate()
        self.setremarkContent()
    }
    
    func setUsername(){
        self.username.text = model.user.firstName
    }
    
    func setUserPicture(){
        
    }
    
    func setRemarkDate(){
        
    }
    
    func setremarkContent(){
        self.remarkContent.numberOfLines = 0;
        self.remarkContent.text = model.content
        
    }
}
