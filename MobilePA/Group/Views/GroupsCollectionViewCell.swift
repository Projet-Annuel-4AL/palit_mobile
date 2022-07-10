//
//  GroupsCollectionViewCell.swift
//  MobilePA
//
//  Created by Lucas Angoston on 10/07/2022.
//

import UIKit

class GroupsCollectionViewCell: UICollectionViewCell {

    static let identifier = "groupsCollectionViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "GroupsCollectionViewCell", bundle: nil)
    }
    
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var groupDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with model: Group){
        self.layer.cornerRadius = 15.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
        self.setGroupTitle(model: model)
        self.setGroupDescription(model: model)
    }

    
    func setGroupTitle(model: Group){
        self.groupTitle.text = model.name
        self.groupTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 19.0)
    }
    
    func setGroupDescription(model: Group){
        self.groupDescription.text = self.truncateString(text: model.description)
        self.groupDescription.numberOfLines = 0
    }
    
    private func truncateString(text: String) -> String{
        return (text.count > 85) ? text.prefix(85) + "..." : text
    }
}
